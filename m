Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3162F5FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 14:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiKRN3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 08:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiKRN2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:28:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0E725C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 05:28:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i12so5384055wrb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFuAN0qalS8PXGclZBpJGpqKwSse98B1zaIXuj/qhsM=;
        b=X/gqqsl/WLpKtb9vOD4WiP4Oi7fWHjwjntx8mX7OxhsG5wzq+ZEu37/nMAgR/K0NTa
         w3qxyDj/5ysz05YJVpUs55kmmloX1IkC2zB1+/KzU94RHSvVV8QJIGUQUlri/5EUyK2r
         mGh3S7znVf5hxcm2FIq10hXZNhSXHhkk0XSUejjdU6tvjBJaDulCkhJ1yHJ5qUwTLhSd
         MoeZaDkThsztpF4G73yNPcJGkFAhdKPv1GGINAnUYMuW1RHIMFNHAh629fNId0Ygj6h4
         QlGc8/i2b3sseFW3mxLr72CnhypCMQDx+K68Ypw8eLM56TGZBoLoX2zeC77yyHo3GfeR
         z9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jFuAN0qalS8PXGclZBpJGpqKwSse98B1zaIXuj/qhsM=;
        b=MWoDIA5UlDQS8kKsIxi8FfeqbRCGEGmNxl5c39D/cDK+q2iGQaTta+Mkim2sxF45ZW
         pp9bsh1cQV2J+zwreajjkIK1XEHl8D2FDKmwiT/qaE+OYNagjayo6EkLab0TrbSLUGPC
         yKt3v3PZ9ZShad19ov9T350DWBBbP7v1xUH5Q3Kwi9IJ4u7WbxHOllayQsgf9OkOUy7f
         sNT5UgzIK8ojrb3aLukx1Jena4Zxe/T3e02b4IqYOCvhsUfiwGTqi0NT9Jmlp+B05s2n
         ru+ChiuUPQIQD2didGi2nkfupO4ZtL5E8/ZhT9dvyr3HGuV1OxVGPxbDDVWGEzHlJHOR
         uyew==
X-Gm-Message-State: ANoB5pkuQ4Spx6MiGx/pANaxp1SQ4CxviZi69Z9lN5gIeHRnYkpFZPtb
        zpRikL9a2VFTY8t23AETC1VwWQ==
X-Google-Smtp-Source: AA0mqf6tYbIf5kiwBxBEeJpBK3Zoi0R3hbVIR4uxKZjI5EAk4XwJowCkhnyQfuyrbXxeKsj5OY9J7w==
X-Received: by 2002:adf:aa91:0:b0:241:b2b2:a71d with SMTP id h17-20020adfaa91000000b00241b2b2a71dmr4389646wrc.326.1668778121454;
        Fri, 18 Nov 2022 05:28:41 -0800 (PST)
Received: from zen.linaroharston ([185.81.254.11])
        by smtp.gmail.com with ESMTPSA id y10-20020adfe6ca000000b00236860e7e9esm3459102wrm.98.2022.11.18.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:28:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 11C631FFB7;
        Fri, 18 Nov 2022 13:28:40 +0000 (GMT)
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <87cz9o9mr8.fsf@linaro.org> <20221116031441.GA364614@chaop.bj.intel.com>
 <87mt8q90rw.fsf@linaro.org> <20221117134520.GD422408@chaop.bj.intel.com>
 <87a64p8vof.fsf@linaro.org> <20221118013201.GA456562@chaop.bj.intel.com>
User-agent: mu4e 1.9.2; emacs 28.2.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Date:   Fri, 18 Nov 2022 13:23:51 +0000
In-reply-to: <20221118013201.GA456562@chaop.bj.intel.com>
Message-ID: <87o7t475o7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Chao Peng <chao.p.peng@linux.intel.com> writes:

> On Thu, Nov 17, 2022 at 03:08:17PM +0000, Alex Benn=C3=A9e wrote:
>>=20
<snip>
>> >> >> > +
>> >> >> > +		/* KVM_EXIT_MEMORY_FAULT */
>> >> >> > +		struct {
>> >> >> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
>> >> >> > +			__u32 flags;
>> >> >> > +			__u32 padding;
>> >> >> > +			__u64 gpa;
>> >> >> > +			__u64 size;
>> >> >> > +		} memory;
>> >> >> > +
>> >> >> > +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that =
the VCPU has
>> >> >> > +encountered a memory error which is not handled by KVM kernel m=
odule and
>> >> >> > +userspace may choose to handle it. The 'flags' field indicates =
the memory
>> >> >> > +properties of the exit.
>> >> >> > +
>> >> >> > + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is=
 caused by
>> >> >> > +   private memory access when the bit is set. Otherwise the mem=
ory error is
>> >> >> > +   caused by shared memory access when the bit is clear.
>> >> >>=20
>> >> >> What does a shared memory access failure entail?
>> >> >
>> >> > In the context of confidential computing usages, guest can issue a
>> >> > shared memory access while the memory is actually private from the =
host
>> >> > point of view. This exit with bit 0 cleared gives userspace a chanc=
e to
>> >> > convert the private memory to shared memory on host.
>> >>=20
>> >> I think this should be explicit rather than implied by the absence of
>> >> another flag. Sean suggested you might want flags for RWX failures so
>> >> maybe something like:
>> >>=20
>> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_READ	(1 << 0)
>> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_WRITE	(1 << 1)
>> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_EXECUTE	(1 << 2)
>> >>         KVM_MEMORY_EXIT_FLAG_PRIVATE            (1 << 3)
>> >
>> > Yes, but I would not add 'SHARED' to RWX, they are not share memory
>> > specific, private memory can also set them once introduced.
>>=20
>> OK so how about:
>>=20
>>  	KVM_MEMORY_EXIT_FLAG_READ	(1 << 0)
>>  	KVM_MEMORY_EXIT_FLAG_WRITE	(1 << 1)
>>  	KVM_MEMORY_EXIT_FLAG_EXECUTE	(1 << 2)
>>         KVM_MEMORY_EXIT_FLAG_SHARED     (1 << 3)
>>         KVM_MEMORY_EXIT_FLAG_PRIVATE    (1 << 4)
>
> We don't actually need a new bit, the opposite side of private is
> shared, i.e. flags with KVM_MEMORY_EXIT_FLAG_PRIVATE cleared expresses
> 'shared'.

If that is always true and we never expect a 3rd type of memory that is
fine. But given we are leaving room for expansion having an explicit bit
allows for that as well as making cases of forgetting to set the flags
more obvious.

--=20
Alex Benn=C3=A9e
