Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB461A5DDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgDLJkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 05:40:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44265 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgDLJkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:40:16 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so6427256iok.11;
        Sun, 12 Apr 2020 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DudAws+5XXDrWI0GuFKZK0uggxlFAK8zrjJOHTOzHvQ=;
        b=oLMyKEkCm7I/W/A1JgYH0WtXqiBHsTY1omrWGoWeTSLEN3CRY+SOrCzgj+j8dXbT3R
         3V4g+VDYJ18ht3BvE76CVfsI9aLy76I2/saDHYI7TAhDY+aCf1QXeuoQj1ierGjq6yUs
         6NQE12G79t/FQbSZxu5L7qhGKRdBhiaUilKHwcCkeiySozNDg8lYnZjgQrtJvlDnddT6
         5lN9bG180nss/feExrMPMJyu1Zky5KVreWqzrGRNCg/KpPYRpunMIP2rzSN7Zwd+vEEv
         jVTerEys3qTK+pzUep1SHCOz4GFY/BEi4vIKQGIetWtTLJpJKPeSuOg2/3EmE7j1Em/i
         Z6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DudAws+5XXDrWI0GuFKZK0uggxlFAK8zrjJOHTOzHvQ=;
        b=CMCm94W+N1aTYLnPG2SsdfB+cYDdO1hrAU/UGJiIGIT+u8BV5EP7RvfqOdcJEXL/N7
         tdJXZEkpIW/B1RytV4gKqBc/2BCYRfCGni9XrhgfaW3jj1863uUiQXAAvfFp+XuQ+gXC
         EXAI/1kUVxZheQmPhQtJzF80lXHT8+HiswyAN9g80NNxlvVdbcf0+Rg54N+rkEkBRhyT
         vJXHK7Ia8Od/O3zAEME0anGGSXgvMRH+tTNC+KgWobPCz7vMkwj6dxyjLAfQxVOHb6TC
         1pfr2mZjpmvyPluExs8hccdvsJdYniKrXcmDL7F7L+dRL4xDuGuHKfdb4RaLjSZNY9xu
         nzhg==
X-Gm-Message-State: AGi0PuayF7XyUEYYFp1oD8ReCUidUjmJVD0Kbuas6kPdKhswlwjz8z2S
        HlV/dqQfqbCUWF+cWDObkwUBcN5L00bk3bvlFCc=
X-Google-Smtp-Source: APiQypKgib8dZi5NZWvrgJ3IJzahp49Bg5kAH7kyRnQiEqTUnZAvY9sH5N9xMqe9W2wkw6a4Vie0NTHrFFJZfCswvCI=
X-Received: by 2002:a6b:cd4a:: with SMTP id d71mr11597681iog.5.1586684415253;
 Sun, 12 Apr 2020 02:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000048518b05a2fef23a@google.com> <20200411161439.GE21484@bombadil.infradead.org>
 <20200412091713.B7282A404D@d06av23.portsmouth.uk.ibm.com>
In-Reply-To: <20200412091713.B7282A404D@d06av23.portsmouth.uk.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 Apr 2020 12:40:04 +0300
Message-ID: <CAOQ4uxg0Fmh58bvTKFyHDhAsmCtgbxpHr+mHYY=O9Wcuo_1JZQ@mail.gmail.com>
Subject: Re: WARNING in iomap_apply
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     syzbot <syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 12:17 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 4/11/20 9:44 PM, Matthew Wilcox wrote:
> > On Sat, Apr 11, 2020 at 12:39:13AM -0700, syzbot wrote:
> >> The bug was bisected to:
> >>
> >> commit d3b6f23f71670007817a5d59f3fbafab2b794e8c
> >> Author: Ritesh Harjani <riteshh@linux.ibm.com>
> >> Date:   Fri Feb 28 09:26:58 2020 +0000
> >>
> >>      ext4: move ext4_fiemap to use iomap framework
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c62a57e00000
> >> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15c62a57e00000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=11c62a57e00000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> >> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 7023 at fs/iomap/apply.c:51 iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51
> >
> > This is:
> >
> >          if (WARN_ON(iomap.length == 0))
> >                  return -EIO;
> >
> > and the call trace contains ext4_fiemap() so the syzbot bisection looks
> > correct.
>
> I think I know what could be going wrong here.
>
> So the problem happens when we have overlayfs mounted on top of ext4.
> Now overlayfs might be supporting max logical filesize which is more
> than what ext4 could support (i.e. sb->s_maxbytes for overlayfs must
> be greater than compared to ext4). So that's why the check in func
> ioctl_fiemap -> fiemap_check_ranges() couldn't truncate to logical
> filesize which the actual underlying filesystem supports.
>
> @All,
> Do you think we should make overlayfs also check for
> fiemap_check_ranges()? Not as part of this fix, but as a later
> addition to overlayfs? Please let me know, I could also make that patch.
>

Yes, I think that would be correct.

Thanks,
Amir.
