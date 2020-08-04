Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A317423BCE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgHDPBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgHDPBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:01:43 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7FCC06174A;
        Tue,  4 Aug 2020 08:01:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 93so20631740otx.2;
        Tue, 04 Aug 2020 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XhqJuEv1/xGyQHnnyK/ITN9b0WHDp3TQhmQqLl33j7c=;
        b=FGSLeKrDziDat+hLwn5Rj3jSg2sgQcQtMhcmMp/Vzj0+Bn9qQTyE1Dh/z9CZHNYN0R
         n7de188/Q1IW/ywrMBLUIo3bhdw9HTsrvhwxGVqiD/89VCgoIV7LBTmZR6VY8sc4YlnU
         3GRLWrFhf+Oa85eA4IPPETRlRukKyZFxp04M2e85FVT3YHPZc3TZTuOfX0LNonMSCJow
         vf3reg8hSTIrKBLikAdvz2eoBRqieVtL8mCjkNzKA+WlOghGe0H/ahHeO1gV8+2SSkFu
         Bn6KbcInncpEtrLfQwGqcUt00X4KePmRgKGMd+LqmKasctvrmBfYA3H6lgKQ33GumtAh
         403Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XhqJuEv1/xGyQHnnyK/ITN9b0WHDp3TQhmQqLl33j7c=;
        b=AScvDzsyykLtBAnGKN1WK97bOiRJUb5sCm3KBUy36fX7bFX/hZfruhdNx6pJO1Yttz
         AKP6usDwl9hPLm7Iq93WLynkYcm5mryH50/7G5QrK0yFrUZmK95yNXgLGcx7MeBmuR9S
         2Yp3qDEGI4AStCvzX+APNjBEQ7VSxQ/lPkduUmgschbMKNZ/Ib71P8+jKCN2jSjfG9WJ
         PJhNMDftc1zur2cAycnKaAGcpSZj8gnZ6r1p9M/tY6pH7847tXLeA7wgAWxRYMBMIZeW
         Bcjqid7bCw4puNBMCK3Yg3gXGMvrOVjDoGVvd5wLx3SwRuHbeRIrIL40BKroVKSAnrvg
         d54Q==
X-Gm-Message-State: AOAM5325a6fj0tdzlpeGE3y1wwYr5K5YFonYN9jiTLz17dJKwofw/LIS
        n5y/Uh1y/gLaMukoqjXQZ7ezdoWjaxEHkYMRGemZaeLy9zg=
X-Google-Smtp-Source: ABdhPJzzuYgKZUCfGLApWr5WTvRXPBPkCeFEqplc+zn5VMbQqnjIeJDJaCWiIbq0toNzo2/eOZWwTpl00ufRtmyoavs=
X-Received: by 2002:a05:6830:13c7:: with SMTP id e7mr14525708otq.19.1596553286552;
 Tue, 04 Aug 2020 08:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <CANsGL8PFnEvBcfLV7eKZQCONoork3EQ7x_RdtkFPXuWZQbK=qg@mail.gmail.com>
 <20200804111913.GA15856@quack2.suse.cz> <20200804113927.GF23808@casper.infradead.org>
In-Reply-To: <20200804113927.GF23808@casper.infradead.org>
From:   nirinA raseliarison <nirina.raseliarison@gmail.com>
Date:   Tue, 4 Aug 2020 18:01:10 +0300
Message-ID: <CANsGL8NYg85aX+H_zD8rbgk9LufdamGLTF3iZkSLw2c-=j0hkg@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:531!
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hello,

# CONFIG_READ_ONLY_THP_FOR_FS is not set



Le mar. 4 ao=C3=BBt 2020 =C3=A0 14:39, Matthew Wilcox <willy@infradead.org>=
 a =C3=A9crit :
>
> On Tue, Aug 04, 2020 at 01:19:13PM +0200, Jan Kara wrote:
> > Hello!
> >
> > On Wed 27-05-20 21:05:55, nirinA raseliarison wrote:
> > > i hit again this bug with:
> > >
> > > $ cat /proc/version
> > > Linux version 5.7.0-rc7.20200525 (nirina@supernova.org) (gcc version
> > > 10.1.0 (GCC), GNU ld version 2.33.1-slack15) #1 SMP Mon May 25
> > > 02:49:28 EAT 2020
> >
> > Thanks for report! I see this didn't get any reply. Can you still hit t=
his
> > issue with 5.8? If yes, what workload do you run on the machine to trig=
ger
> > this? Can you send contents of /proc/mounts please? Thanks!
>
> Also, do you have CONFIG_READ_ONLY_THP_FOR_FS set?
