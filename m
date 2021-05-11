Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D037AB26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 17:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhEKPxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 11:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhEKPxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 11:53:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8815EC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 08:52:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so30436275ejo.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DdK1IEs3eqo+hBsOtkECll5WP9PsnhV8TlKhxE3dq/I=;
        b=z4q41CDYBsfG99gUIBz4qoWmhaIzt02/3aja4FahQ/wKfLjDrFDC6KlAYcrXiOhPPc
         N7laQrcSrnLDR+jl4iNd9aQG0S/HLrBx+SV336S4TclJ/eFPPc+Ky07zmeM1lDVI0O0Q
         v8ZjHcRTdQ49FYjhLeGFPEGX2RonjkA4z3Wbvrf3ORdfY9rE6RxM8sZbJpPtqIIzsM8U
         CE+AtsAiFERUXzAR5d8GoMJyHKiD5Fd6K0NqoVCikDoi7D8ZVaj4z19giOLGIAAcCjXV
         soe8yi1JKQQdwEkeOKgwUaavAvRbmBpNv+KjkQ0+dUmTtV4hN6yJU53ct0HcPGaZlU9Y
         AAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DdK1IEs3eqo+hBsOtkECll5WP9PsnhV8TlKhxE3dq/I=;
        b=uXtm1320WatDGGoRQIORp9XyEfu/x77WS+rYng500eIZ6nHdun+pQNVivlSbBKihDP
         oq4vIPUmYeFYsrhcGC+xjhkh3y5ghgj2TvoLCvbRnS0lU6SHYAPZxv+eR9Hlt7g250GH
         18u/XXd9cDeXs9SNBqmQhISIlaXnf8+sUwRhDDLTj2TodXCMzoOWosU0DwEnUhyD58Qc
         zlIfmtJUvYpH/2FkNirxIBlQ8FViGrmofoVRBAbFYgwb4K639++2BFqCiEN05K11rICa
         N896Q0ofosM/9z6kUBEnJvyhM8d9ij6M2WVbskQaEV6w9Fz+VeBjzyXBdA1cCWSeCu24
         459g==
X-Gm-Message-State: AOAM5324qT73OI1llDPDWiheg4K93u/SoNfyoDWX1UZTSb1xL1om3FW1
        Fj9lNqVI/m7KKiU30ulCZwH2qmQVK4hrGWz5xhJN
X-Google-Smtp-Source: ABdhPJwXdR3PN2nJSGasJfpB5PTCWMNGLNeCcSzPHvc0Lz9sPMStjkc5n2qXBaDNEi5247vUklIg6wzBDktOSIM58ro=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr32304965ejb.542.1620748366074;
 Tue, 11 May 2021 08:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
 <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com> <20210508015443.GA447005@madcap2.tricolour.ca>
 <242f107a-3b74-c1c2-abd6-b3f369170023@schaufler-ca.com> <CAHC9VhQdV93G5N_BKsxuDCtFbm9-xvAkve02t5sGOi9Mam2Wtg@mail.gmail.com>
 <195ac224-00fa-b1be-40c8-97e823796262@schaufler-ca.com> <CAHC9VhTPQ-LoqUYJ4HGsFF-sAXR+mYqGga7TxRZOG7BUD-55FQ@mail.gmail.com>
 <cf7de129-b801-3f0c-64d6-c58d61fd4c84@schaufler-ca.com>
In-Reply-To: <cf7de129-b801-3f0c-64d6-c58d61fd4c84@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 May 2021 11:52:35 -0400
Message-ID: <CAHC9VhS0GU-aE1MkR51VxE7=9s=iDWU2j3=TfmKW1Q6C+jJyxQ@mail.gmail.com>
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:00 AM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
> On 5/10/2021 6:28 PM, Paul Moore wrote:
> > On Mon, May 10, 2021 at 8:37 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
> >> On 5/10/2021 4:52 PM, Paul Moore wrote:
> >>> On Mon, May 10, 2021 at 12:30 PM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> >>>> On 5/7/2021 6:54 PM, Richard Guy Briggs wrote:
> >>>>> On 2021-05-07 14:03, Casey Schaufler wrote:
> >>>>>> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
> >>>>>>> The *setxattr syscalls take 5 arguments.  The SYSCALL record only=
 lists
> >>>>>>> four arguments and only lists pointers of string values.  The xat=
tr name
> >>>>>>> string, value string and flags (5th arg) are needed by audit give=
n the
> >>>>>>> syscall's main purpose.
> >>>>>>>
> >>>>>>> Add the auxiliary record AUDIT_XATTR (1336) to record the details=
 not
> >>>>>>> available in the SYSCALL record including the name string, value =
string
> >>>>>>> and flags.
> >>>>>>>
> >>>>>>> Notes about field names:
> >>>>>>> - name is too generic, use xattr precedent from ima
> >>>>>>> - val is already generic value field name
> >>>>>>> - flags used by mmap, xflags new name
> >>>>>>>
> >>>>>>> Sample event with new record:
> >>>>>>> type=3DPROCTITLE msg=3Daudit(05/07/2021 12:58:42.176:189) : proct=
itle=3Dfilecap /tmp/ls dac_override
> >>>>>>> type=3DPATH msg=3Daudit(05/07/2021 12:58:42.176:189) : item=3D0 n=
ame=3D(null) inode=3D25 dev=3D00:1e mode=3Dfile,755 ouid=3Droot ogid=3Droot=
 rdev=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DNORMAL c=
ap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> >>>>>>> type=3DCWD msg=3Daudit(05/07/2021 12:58:42.176:189) : cwd=3D/root
> >>>>>>> type=3DXATTR msg=3Daudit(05/07/2021 12:58:42.176:189) : xattr=3D"=
security.capability" val=3D01 xflags=3D0x0
> >>>>>> Would it be sensible to break out the namespace from the attribute=
?
> >>>>>>
> >>>>>>      attrspace=3D"security" attrname=3D"capability"
> >>>>> Do xattrs always follow this nomenclature?  Or only the ones we car=
e
> >>>>> about?
> >>>> Xattrs always have a namespace (man 7 xattr) of "user", "trusted",
> >>>> "system" or "security". It's possible that additional namespaces wil=
l
> >>>> be created in the future, although it seems unlikely given that only
> >>>> "security" is widely used today.
> >>> Why should audit care about separating the name into two distinct
> >>> fields, e.g. "attrspace" and "attrname", instead of just a single
> >>> "xattr" field with a value that follows the "namespace.attribute"
> >>> format that is commonly seen by userspace?
> >> I asked if it would be sensible. I don't much care myself.
> > I was *asking* a question - why would we want separate fields?  I
> > guess I thought there might be some reason for asking if it was
> > sensible; if not, I think I'd rather see it as a single field.
>
> I thought that it might make searching records easier, but I'm
> not the expert on that. One might filter on attrspace=3Dsecurity then
> look at the attrname values. But that bikeshed can be either color.

Yeah, understood.  My concern was that the xattr name (minus the
namespace) by itself isn't really useful; similar argument with just
the namespace.  If you are going to do a string match filter it really
shouldn't matter too much either way.

--=20
paul moore
www.paul-moore.com
