Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC94AAA09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380457AbiBEQXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 11:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380470AbiBEQXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:23:51 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691CC06109E;
        Sat,  5 Feb 2022 08:23:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d188so11276636iof.7;
        Sat, 05 Feb 2022 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RfBe7PiUhZZZ9tC02Jrs6j53as/5fNuS6e0YaWMCwVA=;
        b=PbedcvFZpzOc0rOWVShfgcd9b2D+xBpWmTdj7dsmZDMP7Do7KtVlNUyL4yAtIwAxjW
         B49d6wq7QF7H2l0IswaNq7CVjiTUEicZxG03jW75mL+ChFlsnZB3bz4vISxUFKrFHx7f
         uHlFIhRVvHqm9ZxcNnKCXavYOG/Wg4e3cU5TORGQON6VVxfPkVzNmfKfbGae250U+IJu
         UMxZwui61z/hDx//wKaveQwPXzjaGhZtfT6rQRpdnCDPtQb0gzo37gmJzdnRxI1+NSZJ
         GrpOtG+IPVbIWNaZ5Tnjh+TZ8Fjn4hLoqAHBtgmolmM9geUD07QSTwehDxK67CLjYBFw
         zAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfBe7PiUhZZZ9tC02Jrs6j53as/5fNuS6e0YaWMCwVA=;
        b=G4XF7N+7S5Bu41DrB6qux3XDacdOQK5azSpTAo0EVSMNFXsm4BgAy5L4vcWotwQSyc
         C9CAnyRdyq0i0XWYcvzFPdLDuKgC1uu1wBY4V7K0i30O3WbD44HaUBSnStS2edT4rWJ8
         hfxy8VCph5JG+xq43Lnwlk3a8k9vEbIr+70ZbXk+5Iv/WEbsGmr0VIQ1jw6/mcoz5Yvw
         WENNSnA4towhqPPkjwOy9Zo9PWVyq4F7nozT8l/7zoQkPeSl0BUM9Lkb1uWdq9MVyt6P
         nd9n3XmR0IRezt+6Qhddu3PKoM2uGJ6p7xbSqlK9LIdL2AUdG6ZlFl4Kc7Umwy1py6N0
         IGGQ==
X-Gm-Message-State: AOAM531QxunvxGrg2Cy3s6yG7ZzIYa/i/ZtBx5L3seHMy6ZUq1OpidiY
        v/P7/1FDkMjcUN0QjZMQA4K4opUb8X/aBw0jY6ppaaUVXfA=
X-Google-Smtp-Source: ABdhPJxBB+z98BrVcmhEHGZM8qgEP0tTfWFGQts8qdWZAy4sbl4WrZed7UOmPGqkLgL+n6nPptWUtqutrRZXzYqrRyw=
X-Received: by 2002:a05:6638:14d2:: with SMTP id l18mr1999749jak.69.1644078223888;
 Sat, 05 Feb 2022 08:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
 <17d8aeb19ac.f22523af26365.6531629287230366441@mykernel.net>
 <CAOQ4uxgwZoB5GQJZvpPLzRqrQA-+JSowD+brUwMSYWf9zZjiRQ@mail.gmail.com> <362c02fa-2625-30c4-17a1-1a95753b6065@mykernel.net>
In-Reply-To: <362c02fa-2625-30c4-17a1-1a95753b6065@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 5 Feb 2022 18:23:32 +0200
Message-ID: <CAOQ4uxgBBiEiUtbNhcY-H_6+m9JZM_-D+dX0tMGT2oYxc3BSVw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
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

On Sat, Feb 5, 2022 at 6:10 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> =E5=9C=A8 2021/12/7 13:33, Amir Goldstein =E5=86=99=E9=81=93:
> > On Sun, Dec 5, 2021 at 4:07 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
> >>   ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-12-02 06:47:25 Amir=
 Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
> >>   > On Wed, Dec 1, 2021 at 6:24 PM Chengguang Xu <cgxu519@mykernel.net=
> wrote:
> >>   > >
> >>   > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10=
 Jan Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
> >>   > >  > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
> >>   > >  > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@myker=
nel.net> wrote:
> >>   > >  > > > So the final solution to handle all the concerns looks li=
ke accurately
> >>   > >  > > > mark overlay inode diry on modification and re-mark dirty=
 only for
> >>   > >  > > > mmaped file in ->write_inode().
> >>   > >  > > >
> >>   > >  > > > Hi Miklos, Jan
> >>   > >  > > >
> >>   > >  > > > Will you agree with new proposal above?
> >>   > >  > > >
> >>   > >  > >
> >>   > >  > > Maybe you can still pull off a simpler version by remarking=
 dirty only
> >>   > >  > > writably mmapped upper AND inode_is_open_for_write(upper)?
> >>   > >  >
> >>   > >  > Well, if inode is writeably mapped, it must be also open for =
write, doesn't
> >>   > >  > it? The VMA of the mapping will hold file open. So remarking =
overlay inode
> >>   > >  > dirty during writeback while inode_is_open_for_write(upper) l=
ooks like
> >>   > >  > reasonably easy and presumably there won't be that many inode=
s open for
> >>   > >  > writing for this to become big overhead?
> >>   >
> >>   > I think it should be ok and a good tradeoff of complexity vs. perf=
ormance.
> >>
> >> IMO, mark dirtiness on write is relatively simple, so I think we can m=
ark the
> >> overlayfs inode dirty during real write behavior and only remark writa=
ble mmap
> >> unconditionally in ->write_inode().
> >>
> > If by "on write" you mean on write/copy_file_range/splice_write/...
> > then yes I agree
> > since we have to cover all other mnt_want_write() cases anyway.
> >
> >>   >
> >>   > >  >
> >>   > >  > > If I am not mistaken, if you always mark overlay inode dirt=
y on ovl_flush()
> >>   > >  > > of FMODE_WRITE file, there is nothing that can make upper i=
node dirty
> >>   > >  > > after last close (if upper is not mmaped), so one more inod=
e sync should
> >>   > >  > > be enough. No?
> >>   > >  >
> >>   > >  > But we still need to catch other dirtying events like timesta=
mp updates,
> >>   > >  > truncate(2) etc. to mark overlay inode dirty. Not sure how re=
liably that
> >>   > >  > can be done...
> >>   > >  >
> >>   >
> >>   > Oh yeh, we have those as well :)
> >>   > All those cases should be covered by ovl_copyattr() that updates t=
he
> >>   > ovl inode ctime/mtime, so always dirty in ovl_copyattr() should be=
 good.
> >>
> >> Currently ovl_copyattr() does not cover all the cases, so I think we s=
till need to carefully
> >> check all the places of calling mnt_want_write().
> >>
> > Careful audit is always good, but if we do not have ovl_copyattr() in
> > a call site
> > that should mark inode dirty, then it sounds like a bug, because ovl in=
ode ctime
> > will not get updated. Do you know of any such cases?
>
> Sorry for my late response, I've been very busy lately.
> For your question, for example, there is a case of calling
> ovl_want_write() in ovl_cache_get_impure() and caller does not call
> ovl_copyattr()
> so I think we should explicitly mark ovl inode dirty in that case. Is
> that probably a bug?
>
>

The correct behavior would be similar to that of setting impure xattr
in ovl_link_up().
We would want to snapshot the upperdir attrs before removing xattr
and restore them after (best effort).
Not that this case is so important, but if you have an opportunity
to mark inode dirty in ovl_copyattr() I think that would be the best
way to go.

Thanks,
Amir.
