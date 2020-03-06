Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5978517BB7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFLTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 06:19:47 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39920 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCFLTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:19:47 -0500
Received: by mail-il1-f194.google.com with SMTP id q87so1426698ill.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ir8o12rJwmPSb5QkT+B5JmD9MtNoZUDj5M/xzDDH8kc=;
        b=h9CS+eWaNCLkeAgjLdg31tqwtPAJMNWX7CZ0eLNtgKtQw9MiD/aejGYJy/pBccUrZu
         eu7KWsJVQ6zS2//SLYJFgQQEEdnR1t0/rlY0OQ9XKetfh0jxQIZl7RQwE8Vsi2mUkTZ5
         h5tOiu3LZyCrLs/Uv/PMMnhTnbN45KzOglhvqpzpzSV9cHkpkVwRpcdN8iTXzlW3FksH
         brP/PMs2QBAlkLftW1mrQD/0HWR2zBnj1cU+JwiHCMOWUSx7YOmnrPJCJ9o1+NrkujKE
         SV27cVqyqOWe6idbAk0CCos1J/wXjX836KxA4xjwkBVHX5D8oU8vA/60v3FkSreHyDbs
         RNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ir8o12rJwmPSb5QkT+B5JmD9MtNoZUDj5M/xzDDH8kc=;
        b=aSZXWxN+fqVY0E0YAaKvuJ14GPo8IEXIfgGYfyiTd2I73TlWurwAkKMQidmfhWxskc
         2jjCB2dK9Ng9d2tvCa7C3ByTGS7F3/EKAR18pkCUDa3Yqq/o4bNg6SOsSiIFlquhVNYz
         bM2NZJd6mtIViPzeCulTj6r8TCb9kUXBm/zYBgmZOVwljVsrUkpeZZ35GdiMDk2ult9c
         xpTZxXi1eqOfTtV1CWRSgya97dGrizGFZkBm/ZV7HNysD5vxouKVkBZoOJlpevTPPuHo
         VE+QhasKFFAZhdtPHOsN0Cn5XQTxTdk8RXdE2DIs7YucXxf6GOVIesUJItsV4dlJiYtM
         pPng==
X-Gm-Message-State: ANhLgQ13h0XBWd67OwDDigCn2kadoNJCaO6JCRt8lhL40lIvPWw+CjIc
        vOhz6GY5kcT9PqoT7AR9X2qVi8ovX2IX3ewtN/aOQ2Ee
X-Google-Smtp-Source: ADFU+vuNaDwGhbyksvrn8zn/eWvf/jFYe2ljDVOqprGo+fpXItvFYuFfn3GAFT9mjsEhjrbhUVnfTJTUjRhqq9I0Azc=
X-Received: by 2002:a92:dc03:: with SMTP id t3mr2780492iln.137.1583493586429;
 Fri, 06 Mar 2020 03:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz> <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz> <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com> <20200305154908.GK21048@quack2.suse.cz>
In-Reply-To: <20200305154908.GK21048@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 Mar 2020 13:19:34 +0200
Message-ID: <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 5, 2020 at 5:49 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Sun 01-03-20 18:26:25, Amir Goldstein wrote:
> > > > I'd rather do the fanotity_fh padding optimization I outlined in another
> > > > email. That would save one long without any packing and the following u8
> > > > name_len would get packed tightly after the fanotify_fh by the compiler.
> > > >
> > >
> > > OK. I will try that and the non-inherited variant of perm/name event struct
> > > and see how it looks like.
> > >
> >
> > Pushed sample code to branch fanotify_name-wip:
> >
> > b5e56d3e1358 fanotify: fanotify_perm_event inherits from fanotify_path_event
> > 55041285b3b7 fanotify: divorce fanotify_path_event and fanotify_fid_event
>
> Thanks for the work!
>
> > I opted for fanotify_name_event inherits from fanotify_fid_event,
> > because it felt better this way.
>
> I've commented on github in the patches - I'm not sure the inheritance
> really brings a significant benefit and it costs 6 bytes per name event.
> Maybe there can be more simplifications gained from the inheritance (but I
> think the move of fsid out of fanotify_fid mostly precludes that) but at
> this point it doesn't seem to be worth it to me.
>

As agreed on github discussion, the padding is a non issue.
To see what the benefit of inherit fanotify_fid_event is, I did a test patch
to get rid of it and pushed the result to fanotify_name-wip:

* b7eb8314c61b - fanotify: do not inherit fanotify_name_event from
fanotify_fid_event

IMO, the removal of inheritance in this struct is artificial and
brings no benefit.
There is not a single line of code that improved IMO vs. several added
helpers which abstract something that is pretty obvious.

That said, I don't mind going with this variant.
Let me you what your final call is.

Thanks,
Amir.
