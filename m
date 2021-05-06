Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83A5375DA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhEFXmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 19:42:14 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:53715 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhEFXmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 19:42:13 -0400
X-Greylist: delayed 1494 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 19:42:13 EDT
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 146NGIpT043562
        for <linux-fsdevel@vger.kernel.org>; Fri, 7 May 2021 02:16:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1620342973; x=1622934973;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uf0onNfnHBzOPbID0tZ8t011w+r/nxI4x/Q1TyEOdQE=;
        b=PM4UzE0tjJb0ton6+hFqgkCcvCPtBByAxRm712TdGgM8oH0uKI3fYmQulecm+EDP
        VX/y3RFo1wqeqd0M0KT/NGXp67dMJ3EswjXL7/Rvs2m3exSNibfkcTfc4Ds1LdVZ
        zIO1mwOOSeXB/gkB+gBayO9ehtfE1kOLWrgcVaes3kdO9vNH4wOxJv3okCWEcOXq
        7wxQ55OdhLAsE3nZ4q/4x7s7ycQC0w3Gol5dj1eF7An6hnmST3jy8YU3tIa2mTWi
        ctsjP4o/QYbATmSPpaRFC0hLvogkCgCc8SAFLAmz5IdYCrO9I64z/wBrUohkg55F
        bxOCRdo40Lnk7VwOyEhcoA==;
X-AuditID: 8b5b014d-a70347000000209f-ba-609478bd5c23
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id EB.87.08351.DB874906; Fri,  7 May 2021 02:16:13 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 07 May 2021 02:16:03 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     jejb@linux.ibm.com
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Organization: FORTH
In-Reply-To: <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
 <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
Message-ID: <77fe28bd940b2c1afd69d65b6d349352@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA03SfUwTZxzA8Tx317uDrOFEGZdKwNWRbGwrmsn8JTKijs2LRuLMFhUW5AI3
        YEMkLRAmc2EC8qqjtS+uRXlRAUlHoWUwCoQXZQUFXwpaNhHr4I91MNxkTEaHjK5bwj9PPsnv
        l+f5/vHQuH+HSEKnpmcK8nQ+TUr6EmVxus1vdOeoE7Y8rwmBSpORhGXV9xTMNz8n4UldOQLH
        n7MIdJo7CH5uLkKwYFrCoW5eTcCC6g4J2pZAqB1vw8CorMHB8qyYhGLrAgHmqfsi6OoeImDU
        WkmCbuIJCZPGFRHkKx9Q0DZfQMJt6zciuOK4i8GjszvB3luNwb3HBgJuVDgpcI2W43Ba7we2
        M70YLP+wegzftIvguqkdg3F1Hgl992cQqF1NFFjMGhxODZgwuL1sE0HBRAS4F1cfXWyeEu18
        jXtWeJbgjBeNiHMvqRA363IRnDJ/juI69A8prtqcxVkawrhLXS6MMzeWkJz5qYri5m7dorjB
        826Cmx7TYVxFbS/iLg69fyAo1jcySUhLzRbk4VEJvilu0zSWcdUvx5CnovKQ9oVS5EOzzDZ2
        pP4SKkW+tD8zgNjxDhXlHUSwhu4S5LGYWccOfT1NeIwzwGrGepDXIWz+twbcY4IJZQunlzGP
        SeZVtsret7pP0xuYF9k5Y7B3fUHMOpThHq9nBLbu0SjpsR+znn368K7IYx9mH/tTWRfh7WnE
        2CbVH/81RLNttnukt+1l9je3k/LcH7BqywVpBVqnX1OqX1OqX1NajfBGxPDZb8pSExWyj4/L
        M1NkyXIz+vd3of3foQeWX2X9CKNRP2JpXLpBfLP2XIK/OIn/7IQgP35UnpUmKPrRRpqQBorF
        soqj/kwynyl8KggZgvz/KUb7SPIw2ye49vWaA7G7646gV97u3FS/vSc+sGAXzQTzA+8ym22D
        fVdq9w5+0HCygX4skW48Nzw+c3lP/kRMg7mocleU6PCxbbGNY6f4SbrqWkzPaEn5mb25xS99
        eCI0Lqp+UR2wPTc7aEYjuyHZpI4+KZS3HYmov1z11Wyc1nb+gmEpMqA874uglMPD82NO7Zxj
        x+fh4cnYwc6t6SO7i6xJDvvgis+P7YfYmD36GVPxlwMfheXwzEF5xu9ME52YteN0HHM1VP2L
        zKjtlBiynFH7nWVNrVN/C9b49ux3qt5rPRapmNTxRSst5MhkdHohWWFShiRu+ev6W/amVs2h
        ay1B4vjS4FwpoUjht4bhcgX/D3XLkQHMAwAA
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Στις 2021-05-06 20:05, James Bottomley έγραψε:
> On Thu, 2021-05-06 at 18:45 +0200, David Hildenbrand wrote:
>> 
>> Also, there is a way to still read that memory when root by
>> 
>> 1. Having kdump active (which would often be the case, but maybe not
>> to dump user pages )
>> 2. Triggering a kernel crash (easy via proc as root)
>> 3. Waiting for the reboot after kump() created the dump and then
>> reading the content from disk.
> 
> Anything that can leave physical memory intact but boot to a kernel
> where the missing direct map entry is restored could theoretically
> extract the secret.  However, it's not exactly going to be a stealthy
> extraction ...
> 
>> Or, as an attacker, load a custom kexec() kernel and read memory
>> from the new environment. Of course, the latter two are advanced
>> mechanisms, but they are possible when root. We might be able to
>> mitigate, for example, by zeroing out secretmem pages before booting
>> into the kexec kernel, if we care :)
> 
> I think we could handle it by marking the region, yes, and a zero on
> shutdown might be useful ... it would prevent all warm reboot type
> attacks.
> 

I had similar concerns about recovering secrets with kdump, and 
considered cleaning up keyrings before jumping to the new kernel. The 
problem is we can't provide guarantees in that case, once the kernel has 
crashed and we are on our way to run crashkernel, we can't be sure we 
can reliably zero-out anything, the more code we add to that path the 
more risky it gets. However during reboot/normal kexec() we should do 
some cleanup, it makes sense and secretmem can indeed be useful in that 
case. Regarding loading custom kexec() kernels, we mitigate this with 
the kexec file-based API where we can verify the signature of the loaded 
kimage (assuming the system runs a kernel provided by a trusted 3rd 
party and we 've maintained a chain of trust since booting).
