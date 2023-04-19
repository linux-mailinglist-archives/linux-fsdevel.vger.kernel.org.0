Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020D26E74D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjDSIS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSIS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:18:57 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E718B;
        Wed, 19 Apr 2023 01:18:56 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id l13so6856004uan.10;
        Wed, 19 Apr 2023 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681892335; x=1684484335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W22e4ydAV4n5nCBd2MwS4yU05iphAlzsogcBTpIAP90=;
        b=ZhargNF1aPIYqxidwwZ3h5Yfm4PQdEmahsH7VRxaBXgya3HIze6xj6OoXkuKhqw4DO
         awECMItY9eVGCV2JAgs7dWvFjhTUSYBkWmx4J4H7dRXO0SdC3aSJFJUMVfzUOwlmQPRl
         ix4uBroF7y1fzIwSRPesBsbuEKs0OEOZP0EM8HIG3EgC7BN3hSnXoHZhiVG3PuCMqXZs
         FeKemioMZG8Sg/m2nKPYlAoG9xOLBkLfBFH1ur/jlGQ11gh52A8cFjgkEczC1S8U5ohN
         7fJgHZKK3PEvEQsoZphgDpmAMKPMrzxmuYclIC0mtZ4GbFoanmN0aJoTyX0j7QTOZeQ3
         qwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892335; x=1684484335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W22e4ydAV4n5nCBd2MwS4yU05iphAlzsogcBTpIAP90=;
        b=BB3y+3E/VS32/xcVDNEvTMeCXT/GPqT9BVCIaeFGL0VNr9rVN8+GaPrNpt12w837Zi
         1SrOrZzC8SXwYEZi9dnGiAzWeFkHiV58Q0ZXeLwvMHOhWFTYSGgC072xpVdd19E4sv7x
         ECRFRfbzCa/mumYS+wiSASqH9IIAQqfh1fWAcHeGK1p1T8brxXSaPxjEssDv+OWVmgnZ
         uu+0GnZx9YuBEjMqX5faPqgMnf442IbtIYVSXapybWx7YIBUn6CI+BxKVUXzASdGJl0h
         rmXyF1HalblE8GBN8jFHSXMBerTUO83p1SrsfGIQahpuk/cbfL92YGtorxukxQNhDiw6
         fyYg==
X-Gm-Message-State: AAQBX9ftR+ONmw/hZrVXsX0u36Aw+GiJ4m3MNZlhsbjXq7sVAVOwGTfD
        QLQ50UioZXy78J9qcWuK8Wfvyvh871P/R4KDZ+A=
X-Google-Smtp-Source: AKy350ZN3+oKBwJN+I2YD8FIb+KTiqQkUFNRsq2Qvuw8/Jgue8NMWHR/LQ5+y1XDn4YFh2bKAZ2R1zv9gSBHW1LHO8E=
X-Received: by 2002:a1f:a710:0:b0:40c:4d1:b550 with SMTP id
 q16-20020a1fa710000000b0040c04d1b550mr11156104vke.0.1681892335680; Wed, 19
 Apr 2023 01:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
 <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com>
 <CAJfpegsLD-OxYfqPR7AfWbgE1EAPfWs672omt+_u8sYCMFB5Fg@mail.gmail.com>
 <CAOQ4uxhz7g=N0V8iGiKa2+vupEuH_m9_27kas++6c0bLL2qRyA@mail.gmail.com> <CAJfpegt38gHcNeEt1mwOYHeMYdVEbj0RhZEs-4iYG7VPJhYDzQ@mail.gmail.com>
In-Reply-To: <CAJfpegt38gHcNeEt1mwOYHeMYdVEbj0RhZEs-4iYG7VPJhYDzQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Apr 2023 11:18:44 +0300
Message-ID: <CAOQ4uxgzJTg61UOnYQOWggPUX9347gJRafUmQTd=rxxFMEdzrg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] fsinfo and mount namespace notifications
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 9:57 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 18 Apr 2023 at 17:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Apr 18, 2023 at 11:54=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
>
> > > - mount ID's do not uniquely identify a mount across time
> > >   o when a mount is deleted, the ID can be immediately reused
> > >
> > > The following are the minimal requirements needed to fix the above is=
sues:
> > >
> > > 1) create a new ID for each mount that is unique across time; lets
> > > call this umntid
> > >
> >
> > Do you reckon we just stop recycling mntid?
> > Do we also need to make it 64bit?
> > statx() has already allocated 64bit for stx_mnt_id.
> > In that case, should name_to_handle_at() return a truncated mnt_id?
>
> I'm not sure it's realistic to implement the new 64bit ID such that
> the truncated value retains the properties of the previous mount ID
> implementation.
>
> I think the only sane option is to leave the old mnt_id alone and add
> a new 64bit one that is assigned from an atomic counter at allocation
> and looked up using a hash table.
>

At the risk of shoehorning, that sounds a bit like file_handle of a mount.
Meaning that it could be the result of

name_to_handle_at(...,&mount_handle, &mount_id, AT_MNTID)

We can possibly use open_by_handle_at() to get a mountfd from
mount_handle - not sure if that makes sesnse.

[...]

> > > 3) allow querying mount parameters via umntid

I forgot to mention in the context of this topic, that there was a
topic proposal
about using "BFP iterator" [1] to query fs/mount info.

I don't know if that can be used to get namespace change notifications
or if it meets other requirements (i.e. permissions), but wanted to
mention it here.

I think we can discuss both topics in the same session.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/0a6f0513-b4b3-9349-cee5-b0ad38c81=
d2e@huaweicloud.com/
