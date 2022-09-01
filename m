Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10D55A9EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiIASbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIASbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:31:14 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB67659E7
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 11:31:13 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11f34610d4aso22859872fac.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Sep 2022 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DWclz0cI2Qzp/WFkCaK+AoAFDfwG7DzVDaialA7WOVA=;
        b=VQUzR7mE00Iv3vCd3+i0WpUYdn9aP59Pbv4I9ZtntuyG5+07xtyFGsIU9XPMhmJPQr
         Ue7O44guqoWzlr4kDQi/hLdYLyqJcLni8d4CJ5cyhLLZs7PWSroE+/LZLEeSn3ntnXey
         Kvg0CseM0umyM7HTJ2dBL9aK5wP1d1u5vBhRJarQfoIYVPX6pSjlSg5w6Po9NrwG8UYg
         EXN+lx18gHnkJ3659AigDLSmbuPI7SVGfTghpLXw6CZfg9Ij1AYksDyipHc2bH/yZYtV
         K96X+tdewpVSHI+/WIJjuWa5PBRKhYN16yRtsEv3AihoiAGB6IqqgUUB7etOCOCv8dI/
         PMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DWclz0cI2Qzp/WFkCaK+AoAFDfwG7DzVDaialA7WOVA=;
        b=LXcE8yKDiSTDxEYYh5m6nMkXLsPtlPQIHO3mEBwWqNbPHPu+ShbqUU1rHjamVvNtZy
         6ZwoUf3E30egZxNZE6SzhN13Is6QbFC9SVg2MFRxjI5uJnZAHAgu5wkUNmntmkcrBVQ+
         MvPsgOQoYP/xTL1wMxjdZ01pL6KlP+JCa3wNpXuSiJ+O3gsAVUdjB31rYcSFoPmBKHx8
         Wm9xrBybR3Nm59X+aHv6v02sQq2TDEizX1+Z47d3n8R8EC0QP59r0hMm3fitnzkTmYLJ
         vaA9+/v6eyPaQBQYmvuLaQ54TKTmsVyfhy4JcIODZb8O2iaasnICIveH/MLzpaFjPBGo
         Q1NA==
X-Gm-Message-State: ACgBeo0bSKU01+0CwYdiGke4bMIydF/twJj15eLzm+E2og4w3u3Aoh5n
        n6PeyGMhTcTDQ64i9M7OC4Z759m9mRNBzEOqSKAD
X-Google-Smtp-Source: AA6agR4QcciaJ+V9DEP2dfhKeqL/C3Zg9FMWfYLckt6vpWX3sm1XllSrF7qtjHTDSSSTbXuSk2/ZxnQ2UHLplKdsUxo=
X-Received: by 2002:a05:6871:796:b0:11e:b92e:731e with SMTP id
 o22-20020a056871079600b0011eb92e731emr269638oap.41.1662057072424; Thu, 01 Sep
 2022 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <12063373.O9o76ZdvQC@x2>
 <Yw/efLafvmimtCDq@madcap2.tricolour.ca> <5600292.DvuYhMxLoT@x2>
 <CAHC9VhSPS7dRXLU9eV3Ne6Q7q=GPpak+=QRYLa_8Z4i-fESz8w@mail.gmail.com> <20220901075158.jqwaz3pklf3rqc6q@quack3>
In-Reply-To: <20220901075158.jqwaz3pklf3rqc6q@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Sep 2022 14:31:01 -0400
Message-ID: <CAHC9VhStnE9vGu9h5tHnS58eyb8vm8rMN4miXpLAG6fFnidD=w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
To:     Jan Kara <jack@suse.cz>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 1, 2022 at 3:52 AM Jan Kara <jack@suse.cz> wrote:
> On Wed 31-08-22 21:47:09, Paul Moore wrote:
> > On Wed, Aug 31, 2022 at 7:55 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Wednesday, August 31, 2022 6:19:40 PM EDT Richard Guy Briggs wrote:
> > > > On 2022-08-31 17:25, Steve Grubb wrote:
> > > > > On Wednesday, August 31, 2022 5:07:25 PM EDT Richard Guy Briggs wrote:
> > > > > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > > > > index 433418d73584..f000fec52360 100644
> > > > > > > > --- a/kernel/auditsc.c
> > > > > > > > +++ b/kernel/auditsc.c
> > > > > > > > @@ -64,6 +64,7 @@
> > > > > > > > #include <uapi/linux/limits.h>
> > > > > > > > #include <uapi/linux/netfilter/nf_tables.h>
> > > > > > > > #include <uapi/linux/openat2.h> // struct open_how
> > > > > > > > +#include <uapi/linux/fanotify.h>
> > > > > > > >
> > > > > > > > #include "audit.h"
> > > > > > > >
> > > > > > > > @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
> > > > > > > > context->type = AUDIT_KERN_MODULE;
> > > > > > > > }
> > > > > > > >
> > > > > > > > -void __audit_fanotify(u32 response)
> > > > > > > > +void __audit_fanotify(u32 response, size_t len, char *buf)
> > > > > > > > {
> > > > > > > > -       audit_log(audit_context(), GFP_KERNEL,
> > > > > > > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > > > > > > +       struct fanotify_response_info_audit_rule *friar;
> > > > > > > > +       size_t c = len;
> > > > > > > > +       char *ib = buf;
> > > > > > > > +
> > > > > > > > +       if (!(len && buf)) {
> > > > > > > > +               audit_log(audit_context(), GFP_KERNEL,
> > > > > > > > AUDIT_FANOTIFY,
> > > > > > > > +                         "resp=%u fan_type=0 fan_info=?",
> > > > > > > > response);
> > > > > > > > +               return;
> > > > > > > > +       }
> > > > > > > > +       while (c >= sizeof(struct fanotify_response_info_header)) {
> > > > > > > > +               friar = (struct fanotify_response_info_audit_rule
> > > > > > > > *)buf;
> > > > > > >
> > > > > > > Since the only use of this at the moment is the
> > > > > > > fanotify_response_info_rule, why not pass the
> > > > > > > fanotify_response_info_rule struct directly into this function?  We
> > > > > > > can always change it if we need to in the future without affecting
> > > > > > > userspace, and it would simplify the code.
> > > > > >
> > > > > > Steve, would it make any sense for there to be more than one
> > > > > > FAN_RESPONSE_INFO_AUDIT_RULE header in a message?  Could there be more
> > > > > > than one rule that contributes to a notify reason?  If not, would it be
> > > > > > reasonable to return -EINVAL if there is more than one?
> > > > >
> > > > > I don't see a reason for sending more than one header. What is more
> > > > > probable is the need to send additional data in that header. I was
> > > > > thinking of maybe bit mapping it in the rule number. But I'd suggest
> > > > > padding the struct just in case it needs expanding some day.
> > > >
> > > > This doesn't exactly answer my question about multiple rules
> > > > contributing to one decision.
> > >
> > > I don't forsee that.
> > >
> > > > The need for more as yet undefined information sounds like a good reason
> > > > to define a new header if that happens.
> > >
> > > It's much better to pad the struct so that the size doesn't change.
> > >
> > > > At this point, is it reasonable to throw an error if more than one RULE
> > > > header appears in a message?
> > >
> > > It is a write syscall. I'd silently discard everything else and document that
> > > in the man pages. But the fanotify maintainers should really weigh in on
> > > this.
> > >
> > > > The way I had coded this last patchset was to allow for more than one RULE
> > > > header and each one would get its own record in the event.
> > >
> > > I do not forsee a need for this.
> > >
> > > > How many rules total are likely to exist?
> > >
> > > Could be a thousand. But I already know some missing information we'd like to
> > > return to user space in an audit event, so the bit mapping on the rule number
> > > might happen. I'd suggest padding one u32 for future use.
> >
> > A better way to handle an expansion like that would be to have a
> > length/version field at the top of the struct that could be used to
> > determine the size and layout of the struct.
>
> We already do have the 'type' and 'len' fields in
> struct fanotify_response_info_header. So if audit needs to pass more
> information, we can define a new 'type' and either make it replace the
> current struct fanotify_response_info_audit_rule or make it expand the
> information in it. At least this is how we handle similar situation when
> fanotify wants to report some new bits of information to userspace.

Perfect, I didn't know that was an option from the fanotify side; I
agree that's the right approach.

> That being said if audit wants to have u32 pad in its struct
> fanotify_response_info_audit_rule for future "optional" expansion I'm not
> strictly opposed to that but I don't think it is a good idea.

Yes, I'm not a fan of padding out this way, especially when we have
better options.

> Ultimately I guess I'll leave it upto audit subsystem what it wants to have
> in its struct fanotify_response_info_audit_rule because for fanotify
> subsystem, it is just an opaque blob it is passing.

In that case, let's stick with leveraging the type/len fields in the
fanotify_response_info_header struct, that should give us all the
flexibility we need.

Richard and Steve, it sounds like Steve is already aware of additional
information that he wants to send via the
fanotify_response_info_audit_rule struct, please include that in the
next revision of this patchset.  I don't want to get this merged and
then soon after have to hack in additional info.

-- 
paul-moore.com
