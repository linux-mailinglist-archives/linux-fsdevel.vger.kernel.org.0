Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022904DD03E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiCQVfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiCQVfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:35:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C13182AFE
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:34:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d10so13364627eje.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jPzUmEIpYwvREG9Qiji3p50V1VPIn2Vf1DD+hqSFBdM=;
        b=huZ0JPBjL1YpVYiLfjYIe6c0iQgRtRTQfUcrZJD0boOl60Uyju93dGqWGAOfI+kQrl
         JgbKRMsJL2TsWUpKVHZbadiUUP4slD0dFDn4D0BlgQJZerXiSevIWThTiq6+MxBdBStA
         isvXOCoqmHhct4sXt8JbS+qCbxAa7a5xs0E+9BEWETz2kQsy6sJVBB383EaRijbeLiRv
         xzf55aayFuN22IBEf2yxyvJ7Lrbdi+GVuITIi+ECjku6nk6qi+GmhkFx/4PXo+lHo3hi
         nRTPDmQGOf/ywUgzSwgYCWr24hQ5LpPUdg7FHK7nwovsuC6/+pqbjF1UR2QBwj5eymuV
         63ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jPzUmEIpYwvREG9Qiji3p50V1VPIn2Vf1DD+hqSFBdM=;
        b=ye+q09sLf9owtVpXIgA7Ry/OQhjAMjEFk8juZXLQ4RW4wc5SCgGcBR2MeXzQHSdsBm
         wmcp0IHrnS4BAhDz6yb9H735XD3y0qtbTE5dsAv30vuSsYep9ZmvRauEeRO6JlpKc7my
         zl+Sg/NI1u5TMdBR8VSOpyDqxKnZ+pxLCzF1ZLzC6UEukKc8AqeMCTQXtKeX2qTjdeFy
         vNoO22Pwl8fRmnOCdSzDfeLN67ufSCRuxlzxBfrI9Oq2+UJmabjWUsitpTCnPVpdiwuB
         pai9QkJddIb69OMi3PW+45o+iJgj7sY0MLC3Fn310LIm/Za0xh8jjP2P+vNcjXlMVnsx
         LmEQ==
X-Gm-Message-State: AOAM530fmvddEZA31om4AVtwaQwxDfTEhy/hZXOQ79ut3nRai2MgNIwA
        yJPsiLuDqhe072CPy4NO+iuee17MPr5Y9e0xu0EM
X-Google-Smtp-Source: ABdhPJx2XXFfIBn+bpe2QRXQAwg2t49X4tgF1vp9H2ONzdGUmOB9/BUC1ed+OCpABEXPZOVQtjZgIMGHoVRAUh1H5Aw=
X-Received: by 2002:a17:907:3f86:b0:6db:b745:f761 with SMTP id
 hr6-20020a1709073f8600b006dbb745f761mr6082295ejc.610.1647552862768; Thu, 17
 Mar 2022 14:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-5-mic@digikod.net>
 <CAHC9VhT7+Xm+GCg5BqYQgauKOwRxsxfS5WCj+-HW2w6VpaF=6g@mail.gmail.com> <d2ee2504-4daa-18d8-a9c2-083f488984ba@digikod.net>
In-Reply-To: <d2ee2504-4daa-18d8-a9c2-083f488984ba@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Mar 2022 17:34:11 -0400
Message-ID: <CAHC9VhT8j5=U2U8NbOiUNcq+K2NXeNHAM=0vrP4kf9Xj8-tTTA@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] landlock: Fix same-layer rule unions
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 6:40 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 17/03/2022 02:26, Paul Moore wrote:
> > On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >>
> >> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>
> >> The original behavior was to check if the full set of requested access=
es
> >> was allowed by at least a rule of every relevant layer.  This didn't
> >> take into account requests for multiple accesses and same-layer rules
> >> allowing the union of these accesses in a complementary way.  As a
> >> result, multiple accesses requested on a file hierarchy matching rules
> >> that, together, allowed these accesses, but without a unique rule
> >> allowing all of them, was illegitimately denied.  This case should be
> >> rare in practice and it can only be triggered by the path_rename or
> >> file_open hook implementations.
> >>
> >> For instance, if, for the same layer, a rule allows execution
> >> beneath /a/b and another rule allows read beneath /a, requesting acces=
s
> >> to read and execute at the same time for /a/b should be allowed for th=
is
> >> layer.
> >>
> >> This was an inconsistency because the union of same-layer rule accesse=
s
> >> was already allowed if requested once at a time anyway.
> >>
> >> This fix changes the way allowed accesses are gathered over a path wal=
k.
> >> To take into account all these rule accesses, we store in a matrix all
> >> layer granting the set of requested accesses, according to the handled
> >> accesses.  To avoid heap allocation, we use an array on the stack whic=
h
> >> is 2*13 bytes.  A following commit bringing the LANDLOCK_ACCESS_FS_REF=
ER
> >> access right will increase this size to reach 84 bytes (2*14*3) in cas=
e
> >> of link or rename actions.
> >>
> >> Add a new layout1.layer_rule_unions test to check that accesses from
> >> different rules pertaining to the same layer are ORed in a file
> >> hierarchy.  Also test that it is not the case for rules from different
> >> layers.
> >>
> >> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >> Link: https://lore.kernel.org/r/20220221212522.320243-5-mic@digikod.ne=
t
> >> ---
> >>   security/landlock/fs.c                     |  77 ++++++++++-----
> >>   security/landlock/ruleset.h                |   2 +
> >>   tools/testing/selftests/landlock/fs_test.c | 107 +++++++++++++++++++=
++
> >>   3 files changed, 160 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> >> index 0bcb27f2360a..9662f9fb3cd0 100644
> >> --- a/security/landlock/fs.c
> >> +++ b/security/landlock/fs.c
> >> @@ -204,45 +204,66 @@ static inline const struct landlock_rule *find_r=
ule(
> >>          return rule;
> >>   }
> >>
> >> -static inline layer_mask_t unmask_layers(
> >> -               const struct landlock_rule *const rule,
> >> -               const access_mask_t access_request, layer_mask_t layer=
_mask)
> >> +/*
> >> + * @layer_masks is read and may be updated according to the access re=
quest and
> >> + * the matching rule.
> >> + *
> >> + * Returns true if the request is allowed (i.e. relevant layer masks =
for the
> >> + * request are empty).
> >> + */
> >> +static inline bool unmask_layers(const struct landlock_rule *const ru=
le,
> >> +               const access_mask_t access_request,
> >> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_=
FS])
> >>   {
> >>          size_t layer_level;
> >>
> >> +       if (!access_request || !layer_masks)
> >> +               return true;
> >>          if (!rule)
> >> -               return layer_mask;
> >> +               return false;
> >>
> >>          /*
> >>           * An access is granted if, for each policy layer, at least o=
ne rule
> >> -        * encountered on the pathwalk grants the requested accesses,
> >> -        * regardless of their position in the layer stack.  We must t=
hen check
> >> +        * encountered on the pathwalk grants the requested access,
> >> +        * regardless of its position in the layer stack.  We must the=
n check
> >>           * the remaining layers for each inode, from the first added =
layer to
> >> -        * the last one.
> >> +        * the last one.  When there is multiple requested accesses, f=
or each
> >> +        * policy layer, the full set of requested accesses may not be=
 granted
> >> +        * by only one rule, but by the union (binary OR) of multiple =
rules.
> >> +        * E.g. /a/b <execute> + /a <read> =3D /a/b <execute + read>
> >>           */
> >>          for (layer_level =3D 0; layer_level < rule->num_layers; layer=
_level++) {
> >>                  const struct landlock_layer *const layer =3D
> >>                          &rule->layers[layer_level];
> >>                  const layer_mask_t layer_bit =3D BIT_ULL(layer->level=
 - 1);
> >> +               const unsigned long access_req =3D access_request;
> >> +               unsigned long access_bit;
> >> +               bool is_empty;
> >>
> >> -               /* Checks that the layer grants access to the full req=
uest. */
> >> -               if ((layer->access & access_request) =3D=3D access_req=
uest) {
> >> -                       layer_mask &=3D ~layer_bit;
> >> -
> >> -                       if (layer_mask =3D=3D 0)
> >> -                               return layer_mask;
> >> +               /*
> >> +                * Records in @layer_masks which layer grants access t=
o each
> >> +                * requested access.
> >> +                */
> >> +               is_empty =3D true;
> >> +               for_each_set_bit(access_bit, &access_req,
> >> +                               ARRAY_SIZE(*layer_masks)) {
> >> +                       if (layer->access & BIT_ULL(access_bit))
> >> +                               (*layer_masks)[access_bit] &=3D ~layer=
_bit;
> >> +                       is_empty =3D is_empty && !(*layer_masks)[acces=
s_bit];
> >
> >>From what I can see the only reason not to return immediately once
> > @is_empty is true is the need to update @layer_masks.  However, the
> > only caller that I can see (up to patch 4/11) is check_access_path()
> > which thanks to this patch no longer needs to reference @layer_masks
> > after the call to unmask_layers() returns true.  Assuming that to be
> > the case, is there a reason we can't return immediately after finding
> > @is_empty true, or am I missing something?
>
> Because @is_empty is initialized to true, and because each access
> right/bit must be checked by this loop, we cannot return earlier than
> the following if statement. Not returning in this loop also makes this
> helper safer (for potential future use) because @layer_mask will never
> be partially updated, which could lead to an inconsistent state.
> Moreover finishing this bits check loop makes the code simpler and have
> a negligible performance impact.

My apologies, I must have spaced-out a bit and read the 'is_empty =3D
true;' initializer as 'is_empty =3D false;'.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
