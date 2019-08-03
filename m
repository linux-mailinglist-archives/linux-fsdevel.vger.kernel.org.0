Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4937B80784
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfHCRq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 13:46:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45053 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfHCRq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:46:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so75710977ljc.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2019 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p+KPdle0DrLRp9FDoP7922eNS2fl3+QvM+XMS49p18=;
        b=SfAIEP8dYPvPxBXGvQBzqUS9lK22Y5MDsLVnm8uG4aK+sHOgyUCamno+GINWxdqYox
         8nP56Kmrezz8GMbb+krCpuO2OAGa7SarLxIt6fujzohWqRlBdyC8WVFvnZaITEJHRhl0
         Bo0ewzFOwjQdmm1f+brtrHDR/gGM2HxyYU5/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p+KPdle0DrLRp9FDoP7922eNS2fl3+QvM+XMS49p18=;
        b=s171WK69gXE6GZP4gaf1xGbb+n0PPKWBHY3WyzvTQq58FgZ2S9cpprrnN+63SatWSB
         Kl4n+srJc4AlSkJ0QmWg/tbu6veFvXmdT6xkVvdlLgK+DeYLRs9/O+vSfhg+rcSIwqdg
         0mb/v4QNUj7l9zxsE1ATvNe9P/vABkwuzIKCaE5Wb00V2+2w+Pf/pTIaMWHgzhvtHHbY
         IEJaFq93f+e1bS5zqyxe4kUmW3lrmGefMRveGCpicZXVnd2JLMJQDht/RBslB0+g392y
         HI9hzRnSRzn+afIctxNZ+3u98oZqxC4nJZSu6XXQwolMvSX6bj0qLxd/1BVNIXP+0rl1
         z2yQ==
X-Gm-Message-State: APjAAAUIYNu7Ru4awmmRxGBG4sRkYK7Sd1qLwgTuNUYOml+6TjBRlSh1
        jbdQyfHoddVPbU5wdgRxl/j9RuUwZNI=
X-Google-Smtp-Source: APXvYqw2fQZ7TzoaUOubAnYy50dwTOSrnb9urnBJKT68exLtl9T/sBup6PRZf0Jg6BVSmTB8AIPfEg==
X-Received: by 2002:a2e:7a19:: with SMTP id v25mr3775859ljc.39.1564854415850;
        Sat, 03 Aug 2019 10:46:55 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id j23sm13495474lfb.93.2019.08.03.10.46.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 10:46:55 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id s19so55119418lfb.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2019 10:46:54 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr65259782lfb.29.1564854414577;
 Sat, 03 Aug 2019 10:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190803163312.GK7138@magnolia>
In-Reply-To: <20190803163312.GK7138@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Aug 2019 10:46:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
Message-ID: <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: cleanups for 5.3-rc3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 3, 2019 at 9:33 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Here are a couple more bug fixes that trickled in since -rc1.  It's
> survived the usual xfstests runs and merges cleanly with this morning's
> master.  Please let me know if anything strange happens.

Hmm. This was tagged, but not signed like your usual tags are.

I've pulled it (I don't _require_ signed tags from kernel.org), but
would generally be much happier if I saw the signing too...

Thanks,

                 Linus
