Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A612171EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 15:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgB0O32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 09:29:28 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:47016 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbgB0OGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:06:21 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so2474544ilm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 06:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEsHPE/e70ilTvJHK4TF+9xFEd/bOK2mGgerYYXsLXU=;
        b=aB2TLIh97caPPSVHrlI7gB/Qsr5G+PglPfaYcvQOZ711Rk71s4qK3SyyPNOBofq6PJ
         16n0EIYxSyjF6rO0+OrrB5yFI9jBiUyOgGiOUssTZaMlHNmqVZNx0Z6Lb4xYoDNJsjmD
         i3SI9ROGjdkk2vIL1SfNAzUao/h6dib7lRwpQ5X37j0wCivf6rnxj6uitYIzGw6Gw5To
         beqwo3URG0gp43498VpuIUJKdGXY+EaoSgOwAfszaohYvJG7Hp2WwNRsxnQImSfsFg8p
         jCi6Hy9emU6OKklk7nR7eY611Xl4n2W05+6+KypnvFRXRbxaVyhtcB9VCHaAA7xoykFR
         uuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEsHPE/e70ilTvJHK4TF+9xFEd/bOK2mGgerYYXsLXU=;
        b=JKERxANojWfj3nWergxXsSmi3GV0w7OKNnxlT3Hwmi05vl/+qbdO50th0XY/wyjOAI
         PWvpcPuXHfVjdf3MZtpOx1X9hZODon37/3//gnJ2FeBvdVvIRHbm1aC3i45gmJ51s8g8
         CQ8OteXa1nYyDpqObLx1M61TyS/JaV4Z77AsLVo+sHuJRyZqGRpPjkoT91wB35M3HiAS
         NHQn4943/rJHXiQVhL07gTdwvTWJXSPCGWv8KZajsx0BM33RqiJ2vVtdpXik+dJDBKdN
         I6aKc5XQtdXy9tJPJrpCGpszXkdb1BAcgPlJCMV+6X1+mOumrHU6TAw8uk2T+ffg8jiX
         KQ5w==
X-Gm-Message-State: APjAAAUMQ0Pj8d3YX6WYFUDp3A6Gx7VjP0Dm/gk6lVStamoV2iFSERVN
        00phxMz6pRgKlMn+dBbouXrRr14bGCbH+UhdIn8kcw==
X-Google-Smtp-Source: APXvYqxfyHmXghA6EmiHhkaea0juAZOUGdiOI+oX8wzjNYrMJE/zKkfP2cxTodYtAr7QjRC1oUCxh9yFC7mNmVGcjvQ=
X-Received: by 2002:a92:8656:: with SMTP id g83mr6103120ild.9.1582812381168;
 Thu, 27 Feb 2020 06:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz> <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz>
In-Reply-To: <20200227133016.GD10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Feb 2020 16:06:09 +0200
Message-ID: <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 3:30 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 27-02-20 14:12:30, Amir Goldstein wrote:
> > >
> > > > struct fanotify_fh_name {
> > > >          union {
> > > >                 struct {
> > > >                        u8 fh_type;
> > > >                        u8 fh_len;
> > > >                        u8 name_len;
> > > >                        u32 hash;
> > > >                 };
> > > >                 u64 hash_len;
> > > >         };
> > > >         union {
> > > >                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> > > >                 unsigned char *ext_fh;
> > > >         };
> > > >         char name[0];
> > > > };
> > >
> > > So based on the above I wouldn't add just name hash to fanotify_fh_name at
> > > this point...
> > >
> >
> > OK. but what do you think about tying name with fh as above?
> > At least name_len gets to use the hole this way.
>
> Is saving that one byte for name_len really worth the packing? If anything,
> I'd rather do the fanotity_fh padding optimization I outlined in another
> email. That would save one long without any packing and the following u8
> name_len would get packed tightly after the fanotify_fh by the compiler.
>

OK. I will try that and the non-inherited variant of perm/name event struct
and see how it looks like.

Thanks,
Amir.
