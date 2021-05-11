Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC4379C0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhEKBaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 21:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKBaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 21:30:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BED4C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 18:29:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so27230264ejo.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4ykbhAVmu+lXpVg7ewOOB3sVM/0k4gHK4Q6G0qH+bc=;
        b=UPsaHnlkav5P0ZHYqlH+T0ewxbzji8mbzKICq6hQ9GdnRYCgG7Uo0NdIdiW8GfM0xq
         t0Ff6/lBW8zel5SU0MbZSyT8tFGKlV3jNEhk1WcAMncse7VGsDIafgxrVL3wgXcm6XLC
         CMR5J/jVTSQX3DOrdnJCFyE+tCvTt1Hk42ttAgwNdCHkb1LykDbjYXmVRP2LYvgNtwRD
         VeUV7PldVfTNESp1yiVu2cAt8mH4+ODyFDDEhCqtmmQCenmCv9Qq4fJmx6lMn+rR3eWZ
         vxeLC4m98H+5OYZvMP0gg2GLr3rhOETmvLDxsu3If9QSiTNHACYaMSiAPJ4vQscGUemR
         MgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4ykbhAVmu+lXpVg7ewOOB3sVM/0k4gHK4Q6G0qH+bc=;
        b=dGvL/bh03VAH4wll8Y2UaCo7YtwAKt5FSH6pFmW0JA3t4TBSLEFo2tXzBpUAI6UIHl
         HpS+uTcSFs4TKirnfwcVP52agYJ2H8py+3ZZiTgsFFvMgJPB/WNby/IrIyEpb8MmidYr
         ePtqE744KhDEsehiYN2hUoKC8G95bl3GG9x+t6PpX52zmScXlhblh3zj9zyveKE177yN
         +mrnB1caFzOftq0U276mvMyucG/4bNU51esw14dSnKBmBQnmtx7HuMP/5rXpmPo9n03J
         SX91jeaQjGmkDPlBzOBUnJRZV8LiQTtaY0CZpdNysEXUZhST8FgG1mjrw3WIwT+yzNL8
         hZeQ==
X-Gm-Message-State: AOAM530pYbHNbaVJVHTmDBtaiFJrGoDu+Rlud5MLsLa9UPOeDkB4gZOR
        d3JOi0zMb0VoZrKPwbCchN6HW+Xn9aF6/3xRPBS6fpBsGg==
X-Google-Smtp-Source: ABdhPJz3C7SNoneUreqQu3pSZrumUXJNi5gdNEgQTffzpXY31zuDcPbVqpJ7GKH8ZXirUtDVMppuZqKyPoxWdYoc06Y=
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr28682731ejb.488.1620696550709;
 Mon, 10 May 2021 18:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
 <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com> <20210508015443.GA447005@madcap2.tricolour.ca>
 <242f107a-3b74-c1c2-abd6-b3f369170023@schaufler-ca.com> <CAHC9VhQdV93G5N_BKsxuDCtFbm9-xvAkve02t5sGOi9Mam2Wtg@mail.gmail.com>
 <195ac224-00fa-b1be-40c8-97e823796262@schaufler-ca.com>
In-Reply-To: <195ac224-00fa-b1be-40c8-97e823796262@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:28:59 -0400
Message-ID: <CAHC9VhTPQ-LoqUYJ4HGsFF-sAXR+mYqGga7TxRZOG7BUD-55FQ@mail.gmail.com>
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 8:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/10/2021 4:52 PM, Paul Moore wrote:
> > On Mon, May 10, 2021 at 12:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 5/7/2021 6:54 PM, Richard Guy Briggs wrote:
> >>> On 2021-05-07 14:03, Casey Schaufler wrote:
> >>>> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
> >>>>> The *setxattr syscalls take 5 arguments.  The SYSCALL record only lists
> >>>>> four arguments and only lists pointers of string values.  The xattr name
> >>>>> string, value string and flags (5th arg) are needed by audit given the
> >>>>> syscall's main purpose.
> >>>>>
> >>>>> Add the auxiliary record AUDIT_XATTR (1336) to record the details not
> >>>>> available in the SYSCALL record including the name string, value string
> >>>>> and flags.
> >>>>>
> >>>>> Notes about field names:
> >>>>> - name is too generic, use xattr precedent from ima
> >>>>> - val is already generic value field name
> >>>>> - flags used by mmap, xflags new name
> >>>>>
> >>>>> Sample event with new record:
> >>>>> type=PROCTITLE msg=audit(05/07/2021 12:58:42.176:189) : proctitle=filecap /tmp/ls dac_override
> >>>>> type=PATH msg=audit(05/07/2021 12:58:42.176:189) : item=0 name=(null) inode=25 dev=00:1e mode=file,755 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
> >>>>> type=CWD msg=audit(05/07/2021 12:58:42.176:189) : cwd=/root
> >>>>> type=XATTR msg=audit(05/07/2021 12:58:42.176:189) : xattr="security.capability" val=01 xflags=0x0
> >>>> Would it be sensible to break out the namespace from the attribute?
> >>>>
> >>>>      attrspace="security" attrname="capability"
> >>> Do xattrs always follow this nomenclature?  Or only the ones we care
> >>> about?
> >> Xattrs always have a namespace (man 7 xattr) of "user", "trusted",
> >> "system" or "security". It's possible that additional namespaces will
> >> be created in the future, although it seems unlikely given that only
> >> "security" is widely used today.
> > Why should audit care about separating the name into two distinct
> > fields, e.g. "attrspace" and "attrname", instead of just a single
> > "xattr" field with a value that follows the "namespace.attribute"
> > format that is commonly seen by userspace?
>
> I asked if it would be sensible. I don't much care myself.

I was *asking* a question - why would we want separate fields?  I
guess I thought there might be some reason for asking if it was
sensible; if not, I think I'd rather see it as a single field.

> >>>> Why isn't val= quoted?
> >>> Good question.  I guessed it should have been since it used
> >>> audit_log_untrustedstring(), but even the raw output is unquoted unless
> >>> it was converted by auditd to unquoted before being stored to disk due
> >>> to nothing offensive found in it since audit_log_n_string() does add
> >>> quotes.  (hmmm, bit of a run-on sentence there...)
> >>>
> >>>> The attribute value can be a .jpg or worse. I could even see it being an eBPF
> >>>> program (although That Would Be Wrong) so including it in an audit record could
> >>>> be a bit of a problem.
> >>> In these cases it would almost certainly get caught by the control
> >>> character test audit_string_contains_control() in
> >>> audit_log_n_untrustedstring() called from audit_log_untrustedstring()
> >>> and deliver it as hex.
> >> In that case I'm more concerned with the potential size than with
> >> quoting. One of original use cases proposed for xattrs (back in the
> >> SGI Irix days) was to attach a bitmap to be used as the icon in file
> >> browsers as an xattr. Another was to attach the build instructions
> >> and source used to create a binary. None of that is information you'd
> >> want to see in a audit record. On the other hand, if the xattr was an
> >> eBPF program used to make access control decisions, you would want at
> >> least a reference to it in the audit record.
> > It would be interesting to see how this code would handle arbitrarily
> > large xattr values, or at the very least large enough values to blow
> > up the audit record size.
> >
> > As pointed out elsewhere in this thread, and brought up again above
> > (albeit indirectly), I'm guessing we don't really care about *all*
> > xattrs, just the "special" xattrs that are security relevant, in which
> > case I think we need to reconsider how we collect this data.
>
> Right. And you can't know in advance which xattrs are relevant in the
> face of "security=". We might want something like
>
>         bool security_auditable_attribute(struct xattr *xattr)
>
> which returns true if the passed xattr is one that an LSM in the stack
> considers relevant. Much like security_ismaclabel(). I don't think that
> we can just reuse security_ismaclabel() because there are xattrs that
> are security relevant but are not MAC labels. SMACK64TRANSMUTE is one.
> File capability sets are another. I also suggest passing the struct xattr
> rather than the name because it seems reasonable that an LSM might
> consider "user.execbyroot=never" relevant while "user.execbyroot=possible"
> isn't.

Perhaps instead of having the audit code call into the LSM to
determine if an xattr is worth recording in the audit event, we leave
it to the LSMs themselves to add a record to the event?

-- 
paul moore
www.paul-moore.com
