Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2D23EC64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgHGLZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 07:25:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:37187 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgHGLZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:25:38 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200807112535epoutp02149287c7458d1c3adc6aef4aaf7771a2~o_LekbkUD2716827168epoutp02e;
        Fri,  7 Aug 2020 11:25:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200807112535epoutp02149287c7458d1c3adc6aef4aaf7771a2~o_LekbkUD2716827168epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596799535;
        bh=vpt6JHTadTINEfPXkQp2G8+U/htx+npoLwW4CoLiWpY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=XQ50o8Qy7hHoGWrDpgneR3ZH88+wLsnv5ho3IHZy8wyJ/u2iqwDWFCK1V41A0d8kg
         69JnNutdkkvE1BokrP4NjCllOtsMgLdihWTAEd0srRbCD2k+pcEM1AqZ+/0S1/Omio
         h7jan3ZXyyN8G9E5uwShualgQ/bLBy6iYVLXvh2A=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200807112534epcas5p33f1f0f66a68542f2d0087b7880884113~o_LdeuyT92580025800epcas5p3z;
        Fri,  7 Aug 2020 11:25:34 +0000 (GMT)
X-AuditID: b6c32a4a-991ff70000019d8d-55-5f2d3a2e8e77
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.87.40333.E2A3D2F5; Fri,  7 Aug 2020 20:25:34 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] arm64: add support for PAGE_SIZE aligned kernel
 stack
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Vaneet Narang <v.narang@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gladkov.alexey@gmail.com" <gladkov.alexey@gmail.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "walken@google.com" <walken@google.com>,
        "bernd.edlinger@hotmail.de" <bernd.edlinger@hotmail.de>,
        "laoar.shao@gmail.com" <laoar.shao@gmail.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200804061526epcms5p3ff393f7e51d28ed896105c868bd31e5b@epcms5p3>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200807111720epcms5p1206fe967bcee6136774c8432ed5b514b@epcms5p1>
Date:   Fri, 07 Aug 2020 16:47:20 +0530
X-CMS-MailID: 20200807111720epcms5p1206fe967bcee6136774c8432ed5b514b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVwDGPbe3917QLpeC27G4KSRkgrE8guzMGPfQZBeTObbsj2Wbgw4v
        6GwpaYFNjK4bj41qFSuwUgpURQrYDVfkIa3VdSsDgWF1OEAEDD4QSwrKjLWBLqU07r/f+c6X
        78t3cigO30oIqH1ZOawsSySOJILxtt+jYzYJt2xKjXs8vhI5zCz66budSNdsJJC1Ox25510A
        Lai7SNTnneagxvJBHJXfuUsgV/1RgLRPNSTythWS6JTrQ1RwpplA41YDhrrniwjUd0SCxv8s
        5iLDg1ESmSZvcpHlUg+ObnTqCHT2HweGLup6uOj6FT2GWi8XAWT9cQJDZxtmuEjtbMOQraca
        oEuLbhwtqg+hwtHNb0cwxhojYDzP1YDRKlQEU6Vw4MxF7W2SKbSOkIzelMucHrDjjKmphGC6
        NR6cuVxtJJmWum+ZuXsjOOOyDhLMsQtNgHliei0l5NPgrXtY8b48Vha7LS14r3Kqkptdt+ob
        489OTAEmg5QgiIJ0Iiwbc2FKEEzxaTOAdpcOKAFF8egQuNAR6vOE0ilw7uEV4GM+HQGvaYxL
        llA6Dj5v3eCTCVoImzotuI/D6A+g5UED6Yvk0HoK3vIOLx1W0BU4LLzWTfqLeVDzwz3cz+Gw
        3dC6VBBE74LtCx7Cr6+Gw+dmyAC7umqBn8Ng0Vg/x88hcMJtXtbXwnMtquXMAgBL6lhfMaTL
        ADRPK5dD34Dm8zW4f+T78JRhi0/G6ShYNeJYtuyA9v4Wro859DrYPqPj+OwcOho2d8b6La/C
        8qu/YH7LS1DluYsFZnXUBDgKFg6f5wYmPpmbW2qFNANHGkApiNC+eGjt/7q0L7r0gNME1rDZ
        ckkmK9+cnZDFfi2UiyTy3KxMYbpUYgJLXzxmZwe4MzErtAGMAjYAKU5kGO+rqY2pfN4e0YF8
        ViZNleWKWbkNhFN45Cu8yGd9X/DpTFEOu59ls1lZ4BajggQKDBx/mlQsOXk/70So2L42aX3J
        hvfqh6Z3Tbr7Gh92EG/NZjrefGd3tejgUHiiQtq3YlR0U12h0px4/G9DRkoSk2KpT3tdDJOv
        5y8Wv0sez9VIbcO/Ccb+TtjOxO2vOxx/Py1xjSrWmcyPr1G2xgx81pJv161KiAqvLPtrx+4q
        e3eT2X0k9cDsvL5Lbc7pjLb1/7HA1mI9jrLeZxbd1ZHt9ttpRw+PKTIiDNLSQU+7vEJQUDyx
        6P1ceCFi/NHQI+d0nm61PsP2ZRHrpBQfyb2HzuT0Rm/trSyVsp9UHiyIbRzaduOY8FdvQfLU
        Rv1A6TrrrZdRifP0+ozaxe8FlvSVH1dH4vK9ovgYjkwu+g9izAL/UQQAAA==
X-CMS-RootMailID: 20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96
References: <20200804061526epcms5p3ff393f7e51d28ed896105c868bd31e5b@epcms5p3>
        <20200803123447.GA89825@C02TD0UTHF1T.local>
        <1596386115-47228-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96@epcms5p1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Mark, 

>>If you are seeing issues with the current stack size, can you please
>>explain that in more detail? Where are you seeing problems? Which
>>configuration options do you have selected?
>>

We checked on our system with netflix and youtube 4K videos running
max stack consumption was 7 KB:

sh-3.2# cat /sys/kernel/debug/tracing/stack_max_size  
7312

Thus we thought 16KB wil waste a lot of memory for our ARM64 target,
and 8KB can be less in some exceptional case.
So we decided for 12 KB change.


>>I'm not keen on making kernel stack sizes configurable as it's not
>>currently possible for the person building the kernel to figure out a
>>safe size (and if this were possible, it's be better to handle this
>>automatically).
>>

Ok, can we do something else?, like not making it configurable,
but do code changes to support it for PAGE_SIZE aligned stacks
rather than power of 2 alignement.

Although with configurable also, it depends on VMAP stack,
so user will have stack exhaust  exception and can increase acccordingly also.

> 
>Motivation behind these changes is saving memory on our system. 
>Our system runs around 2500 threads concurrently so saving 4Kb  
>might help us in saving 10MB memory.
> 
>To ensure 12KB is sufficient for our system we have used stack tracing and 
>realised maximum stack used is not more than 9KB. 
> /sys/kernel/tracing/stack_max_size
> 
>Tracing interface defined by kernel to track maximum stack size can be used
>by others to decide appropriate stack size.
> 

Thanks
 
