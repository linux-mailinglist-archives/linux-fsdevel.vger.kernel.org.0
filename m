Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04EB7005
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 02:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfISAXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 20:23:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38165 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfISAXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:23:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so1725460ljn.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCq/TbFsgyz/f5qDMbrPu7H+lk7tDCVio2gz6Xsr1jk=;
        b=MjWYHCf0lYOJu/QH9oUEwcZ4Xj+0pYEV8kGM+muk3l+vc2eBgT0GnILRm6E3K4upAv
         5wJi52x8CcGq4MaaKRKZbiGJU7VX9PpS0ne8bpsgPDNKYXV2yG3+G+2sYqoKkGTFDQaT
         0DBmxCjXSSuy8q0/7sfftCtDXqZMtkWb+bWtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCq/TbFsgyz/f5qDMbrPu7H+lk7tDCVio2gz6Xsr1jk=;
        b=RpWeXqgQ9twI0q3UJswpFPmvvpRePFuJuuqeArURQjuq4VTJoDx0lkU11zz3PCyeVK
         4bzlVwAnH1qt0kUmfyGEsZhB0N6dKv5qHFhlXiiGA4Bx1oX7TQGfIcdhfN7ZTs6NzFPP
         K9nHAseKxCPmtfFDYj17MRcsNaz1FOkDuxu3sJhCpq/Kv4jJK6hzCVO527a/9YBh2u8t
         iVtwxW3uMWUkoxzebQYg/behy2ih3T6uBTYIbPUpG2lLhv7Rmewm/Db7V5z3thEQBNSQ
         banGPJ/APMRij5nB2TiOIYBfwAmgBQq1VnpjIFerOmdGsXSQMX4L+luVWk5ODFjlnzJW
         o3nA==
X-Gm-Message-State: APjAAAXaj2pa3J4QiFmTuMkjjvBI9P7gZn16vLVTlkMhuHc6YNWjn57r
        /B5j8h9HomFi98dX8oy6wp5LLDfzLmI=
X-Google-Smtp-Source: APXvYqwjXU19AUebU2Qim+EZueA75797/9AQkoTFkiFNmWdkbYZ74dCPUmgY6a3IO65/lm93pu0MCQ==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr3738756ljh.101.1568852592003;
        Wed, 18 Sep 2019 17:23:12 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y22sm1241592lfb.75.2019.09.18.17.23.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:23:11 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e17so1665466ljf.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 17:23:10 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr3795217ljj.72.1568852590551;
 Wed, 18 Sep 2019 17:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <16147.1568632167@warthog.procyon.org.uk>
In-Reply-To: <16147.1568632167@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 17:22:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
Message-ID: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
Subject: Re: [GIT PULL afs: Development for 5.4
To:     David Howells <dhowells@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 4:09 AM David Howells <dhowells@redhat.com> wrote:
>
> Here's a set of patches for AFS.  The first three are trivial, deleting
> unused symbols and rolling out a wrapper function.

Pulled.

However, I was close to unpulling it again. It has a merge commit with
this merge message:

    Merge remote-tracking branch 'net/master' into afs-next

and that simply is not acceptable.

Commit messages need to explain the commit. The same is even more true
of merges!

In a regular commit, you can at least look at the patch and say "ok,
that  change is obvious and self-explanatory".

In a merge commit, the _only_ explanation you have is basically the
commit message, and when the commit message is garbage, the merge is
garbage.

If you can't explain why you are doing a merge, then you shouldn't do
the merge. It's that simple.

And if you can't be bothered to write the explanation down, I'm not
sure I can be bothered to then pull the end result.

             Linus
