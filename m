Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920866F8FA0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEFHHT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 6 May 2023 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFHHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 03:07:18 -0400
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 May 2023 00:07:16 PDT
Received: from p3plsmtpa07-08.prod.phx3.secureserver.net (p3plsmtpa07-08.prod.phx3.secureserver.net [173.201.192.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0225B95
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 00:07:16 -0700 (PDT)
Received: from mail-ej1-f54.google.com ([209.85.218.54])
        by :SMTPAUTH: with ESMTPSA
        id vByVpxAjerKprvByWpoiPS; Sat, 06 May 2023 00:05:00 -0700
X-CMAE-Analysis: v=2.4 cv=U+5UT8nu c=1 sm=1 tr=0 ts=6455fc1c
 a=P7SCm5FBaGkOUgmNSK28lg==:117 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10
 a=xVhDTqbCAAAA:8 a=20KFwNOVAAAA:8 a=rDwt1Zk6MRkbpbuKzqYA:9 a=QEXdDO2ut3YA:10
 a=GrmWmAYt4dzCMttCBZOh:22
X-SECURESERVER-ACCT: kaiwan@kaiwantech.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso461949766b.2;
        Sat, 06 May 2023 00:04:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDwcLV1Z38hwh05MO+Nm0W6u2B1VnIg3W2krWN3xEFmrLOfW+R11
        H5I7dOG/DBve7QNgqDW7XfWntMfUQNWOD7YA06M=
X-Google-Smtp-Source: ACHHUZ62GVBTMauDj5I48KnvfLs0gNpt0Jrh6TAkoSyEVAeNlL8OxCphSpqv3XTKacR+8uhZXSKmFENDlCZxOsMFjyw=
X-Received: by 2002:a17:907:70a:b0:953:9024:1b50 with SMTP id
 xb10-20020a170907070a00b0095390241b50mr2753174ejb.74.1683356699105; Sat, 06
 May 2023 00:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
 <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com> <87pm7f9q3q.fsf@gentoo.org>
 <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com> <CAHC9VhTX3ohxL0i3vT8sObQ+v+-TOK95+EH1DtJZdyMmrm3A2A@mail.gmail.com>
In-Reply-To: <CAHC9VhTX3ohxL0i3vT8sObQ+v+-TOK95+EH1DtJZdyMmrm3A2A@mail.gmail.com>
From:   Kaiwan N Billimoria <kaiwan@kaiwantech.com>
Date:   Sat, 6 May 2023 12:34:41 +0530
X-Gmail-Original-Message-ID: <CAPDLWs-=C_UTKPTqwRbx70h=DaodF8LVV3-8n=J3u=L+kJ_1sg@mail.gmail.com>
Message-ID: <CAPDLWs-=C_UTKPTqwRbx70h=DaodF8LVV3-8n=J3u=L+kJ_1sg@mail.gmail.com>
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
To:     Paul Moore <paul@paul-moore.com>
Cc:     David Hildenbrand <david@redhat.com>, Sam James <sam@gentoo.org>,
        Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org, serge@hallyn.com, tycho@tycho.pizza,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfOLF0OZGXs3zvdVu+45H+IY/2xijwTZGNs1nUXkYlr5TVDia0ayb8+MrvWSJDiz1EW9wFDwiThMzy3bcVc828R0VhIs10KxHnf5OCbhAVmORWYG/glGC
 e5JvmmbrELQ7y1G9q7SNzcUgJ8vxydd0GzcOIcSAtB3UFvkQK7RHMtX91ow3BCitIVVQiXF6jctF10v+tCrwkqm8UpdJI2Er8jdAzu6zM53FmqE50nJxDqfj
 9C+dN12HSuMemXaDfYQV28HuYiyQPV7G0HtugajIllk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 5, 2023 at 8:53 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, May 5, 2023 at 11:15 AM David Hildenbrand <david@redhat.com> wrote:
> > On 05.05.23 09:46, Sam James wrote:
> > > David Hildenbrand <david@redhat.com> writes:
> > >> On 04.05.23 23:30, Michael McCracken wrote:
> > >>> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
> > >>> sysctl to 0444 to disallow all runtime changes. This will prevent
> > >>> accidental changing of this value by a root service.
> > >>> The config is disabled by default to avoid surprises.
>
> ...
>
> > If we really care, not sure what's better: maybe we want to disallow
> > disabling it only in a security lockdown kernel?
>
> If we're bringing up the idea of Lockdown, controlling access to
> randomize_va_space is possible with the use of LSMs.  One could easily
> remove write access to randomize_va_space, even for tasks running as
> root.
IMO, don't _move_ the sysctl to LSM(s). There are legitimate scenarios
(typically debugging) where root needs to disable/enable ASLR.
I think the key thing is the file ownership; being root-writable takes
care of security concerns... (as David says, if root screws around we
can't do much)..
If one argues for changing the mode from 0644 to 0444, what prevents
all the other dozens of sysctls - owned by root mind you - from not
wanting the same treatment?
Where does one draw the line?
- Kaiwan.
>
> (On my Rawhide system with SELinux enabled)
> % ls -Z /proc/sys/kernel/randomize_va_space
> system_u:object_r:proc_security_t:s0 /proc/sys/kernel/randomize_va_space
>
> --
> paul-moore.com
