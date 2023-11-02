Return-Path: <linux-fsdevel+bounces-1810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20637DF0C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C191281ADD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B29E14273;
	Thu,  2 Nov 2023 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSQ8ZzZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881E14006
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:01:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AA0133
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698922908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WEsP6UmyH+BX0JZ3F1lGKvqULOvcqKbb9QU0pxprrbY=;
	b=JSQ8ZzZRgLWbzhfCdaUcHK/rzyB19nqEoQFs4/2y4V5ys3awZbhIH8BNDepeMEPt+8tFSk
	Fi3oQZcmFiu3eR1EIq9NbXrQwgG0baZqr/JYUrKA2TMGoxhNNs2JXCkj+18sdeUMm1uZjI
	LcPrqAVKQQw1YrJpq2fTGWr6/NqlBno=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-tSln1Gp1NCyC_YL7nGv6vA-1; Thu, 02 Nov 2023 07:01:47 -0400
X-MC-Unique: tSln1Gp1NCyC_YL7nGv6vA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d30a6a67abso54226966b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 04:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698922906; x=1699527706;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEsP6UmyH+BX0JZ3F1lGKvqULOvcqKbb9QU0pxprrbY=;
        b=AEQiib1MB3DgoK57c5YnS1mnF9coKbcX8F+ujPFPcLHfDhqEXLWDm8Q4pIGE23mO4D
         wL2TeuzamThRQmdAWBLgQCOCmHKCWi3DSxrktDwiviM1wIYIwqhPAOjgFDLs1HPAJ3Ui
         fz8ffZNeAszB5cyj6HpI5t3LXGG4j9Euyl//LvCyY6qWmEDwgs7Fl9xQzInGXGEVfCqj
         GOyu/SIVQto6JxyhlIA6Bk1YAFyBqShmjAm1KWLCghcd/Qi5sYiRuzO9R81+bWSYrNvL
         IHtVXneWhrqhPFFNxgCgGKmCETlr7Zv57KVTmyX/YbebKwf9qpE0daShKfvy+A+DxFLF
         hQ7g==
X-Gm-Message-State: AOJu0YylpdS1lYewxtPhU5YfFT5hxbJeQ33G60lohbFX+qagOJGxtFvu
	ancDQw23dWLJqVmwaJ2LdIIvr57aC3Rq/tmdDsdz9nUZeWfFL3Hak+c5kGfhDBFBePbVhW2RvW+
	yromPWabyYLr+q4p9k6lXyCdsUA==
X-Received: by 2002:a17:906:d90:b0:9ba:a38:531e with SMTP id m16-20020a1709060d9000b009ba0a38531emr3519608eji.52.1698922905984;
        Thu, 02 Nov 2023 04:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr1MKwEsucdCPGHuXwuvbKOwjSvBNOm32t6vlzmUKLac2E5/jR4RLI2SEmoEufOHPDYy6Ibw==
X-Received: by 2002:a17:906:d90:b0:9ba:a38:531e with SMTP id m16-20020a1709060d9000b009ba0a38531emr3519582eji.52.1698922905598;
        Thu, 02 Nov 2023 04:01:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id a8-20020a170906684800b00993a37aebc5sm983006ejs.50.2023.11.02.04.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 04:01:44 -0700 (PDT)
Message-ID: <e6025e28-ea93-458b-887f-925eab7cf260@redhat.com>
Date: Thu, 2 Nov 2023 12:01:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "maz@kernel.org"
 <maz@kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "willy@infradead.org" <willy@infradead.org>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
 "mic@digikod.net" <mic@digikod.net>,
 "liam.merwick@oracle.com" <liam.merwick@oracle.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "david@redhat.com" <david@redhat.com>, "tabba@google.com"
 <tabba@google.com>, "amoorthy@google.com" <amoorthy@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Vishal Annapurve <vannapurve@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
 "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
 "qperret@google.com" <qperret@google.com>,
 "dmatlack@google.com" <dmatlack@google.com>, Yilun Xu <yilun.xu@intel.com>,
 "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Wei W Wang <wei.w.wang@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-10-seanjc@google.com>
 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
 <ZUKMsOdg3N9wmEzy@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <ZUKMsOdg3N9wmEzy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/23 18:36, Sean Christopherson wrote:
> A good example is KVM_RUN with -EINTR; if KVM were to return something other than
> -EINTR on a pending signal or vcpu->run->immediate_exit, userspace would fall over.

And dually if KVM were to return KVM_EXIT_INTR together with something 
other than -EINTR.

> And purging exit_reason super early is subtly tricky because KVM's 
> (again, poorly documented) ABI is that *some* exit reasons are preserved 
> across KVM_RUN with vcpu->run->immediate_exit (or with a pending 
> signal). https://lore.kernel.org/all/ZFFbwOXZ5uI%2Fgdaf@google.com

vcpu->run->immediate_exit preserves all exit reasons, but it's not a 
good idea that immediate_exit behaves different from a pending signal on 
entry to KVM_RUN (remember that immediate_exit was meant to be a better 
performing alternative to KVM_SET_SIGNAL_MASK).

In principle, vcpu->run->immediate_exit could return KVM_EXIT_INTR 
(perhaps even _should_, except that breaks selftests so at this point it 
is ABI).

Paolo


