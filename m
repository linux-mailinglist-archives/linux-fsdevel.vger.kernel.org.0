Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380B52CBB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 08:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiESGEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 02:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiESGEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 02:04:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C66D1B8;
        Wed, 18 May 2022 23:04:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l1so3931469qvh.1;
        Wed, 18 May 2022 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c13GsineKBPH3FpZauvIg5yJIxFG3aFkuMJ2bjSLRso=;
        b=LH2942CznfewiPiZdI4Q7PurIbVqFwnoi0qTfz3PW2klXuREqqFzJJ7pyel08G4W00
         2B//pg5yytSGNizkOAE5YcQqxr6Dyd8JDPmiG4B7Hhm9xjKLbBC9eCVFPoz/w1HW1jmd
         ZP5Mi8oz4mc16S0SauYQe7BO/WRI04aRGAsvH0AiiUfOrnb+XGVWU4LOSMtXeE3Yqkmb
         qrSp2Uar+AFqWpR5UUcWQksFiTG4GKS4aSo2yZyET4AgFbLukQBvoB213rmBMFshOOAa
         KmsQxpb1PNCaP+BK5befjbYfKFK+4N6ZhnTcNAuJSIHAtWvmgm2TbLi4gpnTyD3/4j+J
         THgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c13GsineKBPH3FpZauvIg5yJIxFG3aFkuMJ2bjSLRso=;
        b=My8F2zogVgqmuigo0EswHeATihRp39hCCNipAwoBwiJZ+0F3yf76ex4LEL36L3h0wQ
         uj/KMqidIjYggCsEzFZGxBEtVOewBtscwhGxWTZ4O6IakBqeLffRt3g9wjcVNmvMWTF7
         Ho/OFW0JYe+WH8AwGZU8hGehaGEVNxrgRaVAMptBnABhQGyENsJEcSR2TOhUi6nyun7j
         idZqS6w2Um7OncWUmRQo/3j1ZWuo1xhvbs5Qtuq/WP5lSxqSWHIcK4094jVLbGSFVDbP
         dUeySjTK8ty5yfvsh8z8DqmtsZ5qpKR2CWHVIqNr3Ktj6OnRMuG+Mf0oCbDX6aC+s3Z7
         XfKQ==
X-Gm-Message-State: AOAM532LpCzlwxEXqCyA/z8MD79EVl5P7B+AU+ptCC58ysIwdo2dtNd7
        VwENWlGSaY5xaR8azIvdawtc/9MblaCbXjhGYmA=
X-Google-Smtp-Source: ABdhPJzb7dI713Uy6MktIie16aaZL44v+i1rrStclkXVVpkvHTQVN1jOSLNnlqgR72w2Vm29Ol5A4FO4bFRxKAaYaUE=
X-Received: by 2002:a05:6214:5296:b0:461:d3bb:ba01 with SMTP id
 kj22-20020a056214529600b00461d3bbba01mr2560449qvb.12.1652940242976; Wed, 18
 May 2022 23:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652730821.git.rgb@redhat.com> <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
 <CAOQ4uxjV-eNxJ=O_WFTTzspCxXZqpMdh3Fe-N5aB-h1rDr_1hQ@mail.gmail.com> <YoWKPcsySt9cJbtB@madcap2.tricolour.ca>
In-Reply-To: <YoWKPcsySt9cJbtB@madcap2.tricolour.ca>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 May 2022 09:03:51 +0300
Message-ID: <CAOQ4uxi+8HUqyGxQBNMqSong92nreOWLKdy9MCrYg8wgW9Dj4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fanotify: define struct members to hold response
 decision context
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > However, this behavior change is something that I did ask for, but it should be
> > done is a separate commit:
> >
> >  /* These are NOT bitwise flags.  Both bits can be used together.  */
> > #define FAN_TEST          0x00
> > #define FAN_ALLOW       0x01
> > #define FAN_DENY        0x02
> > #define FANOTIFY_RESPONSE_ACCESS \
> >             (FAN_TEST|FAN_ALLOW | FAN_DENY)
> >
> > ...
> > int access = response & FANOTIFY_RESPONSE_ACCESS;
> >
> > 1. Do return EINVAL for access == 0
>
> Going back to the original code will do that.

Oops, this was supposed to be Do NOT return EINVAL for access == 0
this is the case of FAN_TEST.
The patch I posted later explains that better.

>
> > 2. Let all the rest of the EINVAL checks run (including extra type)
> > 3. Move if (fd < 0) to last check
> > 4. Add if (!access) return 0 before if (fd < 0)
> >
> > That will provide a mechanism for userspace to probe the
> > kernel support for extra types in general and specific types
> > that it may respond with.
>
> I'm still resisting the idea of the TEST flag...  It seems like an
> unneeded extra step and complication...

Please reply to the patch I posted as a reply as point
at said complication. There is no extra step.

>
> The simple presence of the FAN_EXTRA flag should sort it out and could
> even make TEST one of the types.
>

I think you've missed the point of the TEST response code.
The point of the TEST response code is to test whether the
extra type is supported, so TESTS cannot be a type.

You should not think of FAN_TEST as a flag at all, in
fact, it is semantic and can be omitted altogether.

The core of the idea is that:
int access = response & FANOTIFY_RESPONSE_ACCESS;

access is an enum, not a bitwise mask, much like:

unsigned int class = flags & FANOTIFY_CLASS_BITS;
unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;

At the moment, userspace must provide a valid access code
either ALLOW or DENY.
Providing no access code (0) is not valid.
I suggest making FAN_EXTRA with no access code a valid
response for testing the EXTRA types support.
(please refer to the patch)

[...]


> > > + * size is determined by the extra information type.
> > > + *
> > > + * If the context type is Rule, then the context following is the rule number
> > > + * that triggered the user space decision.
> > > + */
> > > +
> > > +#define FAN_RESPONSE_INFO_NONE         0
> > > +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> > > +
> > > +union fanotify_response_extra {
> > > +       __u32 audit_rule;
> > > +};
> > > +
> > >  struct fanotify_response {
> > >         __s32 fd;
> > >         __u32 response;
> > > +       __u32 extra_info_type;
> > > +       union fanotify_response_extra extra_info;
> >
> > IIRC, Jan wanted this to be a variable size record with info_type and info_len.
>
> Again, the intent was to make it fixed for now and change it later if
> needed, but that was a shortsighted approach...
>
> I don't see a need for a len in all response types.  _NONE doesn't need
> any.  _AUDIT_RULE is known to be 32 bits.  Other types can define their
> size and layout as needed, including a len field if it is needed.
>

len is part of a common response info header.
It is meant to make writing generic code.
So Jan's email.

> > I don't know if we want to make this flexible enough to allow for multiple
> > records in the future like we do in events, but the common wisdom of
> > the universe says that if we don't do it, we will need it.
>
> It did occur to me that this could be used for other than audit, hence
> the renaming of the ..."_NONE" macro.
>
> We should be able in the future to define a type that is extensible or
> has multiple records.  We have (2^32) - 2 types left to work with.
>

The way this was done when we first introduced event info
records was the same. We only allowed one type of record
and a single record to begin with, but the format allowed for
extending to multiple records.

struct fanotify_event_metadata already had event_len and
metadata_len, so that was convenient. Supporting multi
records only required that every record has a header with its
own len.

As far as I can tell, the case of fanotify_response is different
because we have the count argument of write(), which serves
as the total response_len.

If we ever want to be able to extend the base fanotify_response,
add fields to it not as extra info records, then we need to add
response_metadata_len to struct fanotify_response, but I think that
would be over design.

Thanks,
Amir.
