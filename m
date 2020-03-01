Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9E174E72
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgCAQ0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 11:26:37 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:32973 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQ0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:26:37 -0500
Received: by mail-il1-f196.google.com with SMTP id r4so5837344iln.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2020 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fu/SFHWPJrdodZVxzytASHZbQ3cU0h0DDwJDKjhPkA=;
        b=YfuH4I2pz3kQJiHoeONb32Dlr+t+Kk90lPCRMd/Q6NgfdKTO9rug4I1SKFvDjFUlf2
         jXzE4sNRhUHqq2hmFE5fREXsqh8fksIWRLOHbjFaJ9kXnIPRgP0LjsG6Y7gMJylGLW5w
         q3B4t8yGYNjl78Rn97eMlwHP9IklCkYrlKvBo08tTh95yEx+zWWXdMbc1aze7sFhR7xB
         cQy3BhDvZuJI1oO1KT0L0IBgcBUpY8FvO7jQfvfl+HEXwfPw1LPTTU3NERRKr/ckYlav
         Nu2+MIqbsFhYnMBe6jK6TvLoKU22dAbCdt7q6lqJhL8PtiNMqffJ3u4MppnRl3z7AMGR
         xoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fu/SFHWPJrdodZVxzytASHZbQ3cU0h0DDwJDKjhPkA=;
        b=AYazfCNkahYI3C75L1Qc9gJBLJo4vekjfOzD43yypVq2YalNBAW8RWFYqKLkG44JDO
         Rt/GSm5U8a5sH8tUMEuize781ukd4wq9hE/2lEXx97QkbzN6Zf0o/ziqN5ep2e5CtFtj
         7Bw+eeEjpCjxZCDUPC0HzdmMJjVJdy2nUCrxxILZau5xXdYg9jBqyoncH59sMvwTEHvo
         ZlU8Bdu8TsJctZITuHC7nsLomPOYQ3dLdHfrtu6BYkwls3xPoE732hA3yF43vVUyL9yk
         hdghxWIHTuVbUjK3mDR5dyDxRXu45GGFyDmbTuUUyZeHdTa+zSWZeZD9D8zb+GenqRH+
         zO/g==
X-Gm-Message-State: APjAAAUjOoGOxaCCf9zCAl7K7MYAomllwNnnsmLbN/onExAmbeEIutc0
        h5GYvjv8/4gxlphzGtjiTFIIq4K9j+sNmGfVhyPkhyzn
X-Google-Smtp-Source: APXvYqzMyIGaKPx99XsAsqXJVkY1PO54XE1cuJFcv6kj6XYCkzpyMGCH5sntyL4uusM3cDhDQtUyHHpb6mgWSAWrPiw=
X-Received: by 2002:a92:6f10:: with SMTP id k16mr13154990ilc.275.1583079996785;
 Sun, 01 Mar 2020 08:26:36 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz> <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz> <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 1 Mar 2020 18:26:25 +0200
Message-ID: <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I'd rather do the fanotity_fh padding optimization I outlined in another
> > email. That would save one long without any packing and the following u8
> > name_len would get packed tightly after the fanotify_fh by the compiler.
> >
>
> OK. I will try that and the non-inherited variant of perm/name event struct
> and see how it looks like.
>

Pushed sample code to branch fanotify_name-wip:

b5e56d3e1358 fanotify: fanotify_perm_event inherits from fanotify_path_event
55041285b3b7 fanotify: divorce fanotify_path_event and fanotify_fid_event

I opted for fanotify_name_event inherits from fanotify_fid_event,
because it felt
better this way.
I wasn't sure about fanotify_perm_event inherits from fanotify_path_event,
so did that is a separate patch so you can judge both variants.
IMO, neither variant is that good or bad, so I could go with either.

I do like the end result with your suggestions better than fanotify_name-v2.
If you like this version, I will work the changes into the series.

Thanks,
Amir.
