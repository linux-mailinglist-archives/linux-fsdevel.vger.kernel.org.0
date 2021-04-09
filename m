Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF82135A46F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhDIROY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 13:14:24 -0400
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169]:59637 "EHLO
        smtp-8fa9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234067AbhDIROX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:14:23 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FH4VT1gsRzMqjJ5;
        Fri,  9 Apr 2021 19:14:09 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4FH4VN3Z5Yzlh8T2;
        Fri,  9 Apr 2021 19:14:04 +0200 (CEST)
Subject: Re: [PATCH v12 0/3] Add trusted_for(2) (was O_MAYEXEC)
To:     bauen1 <j2468h@googlemail.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, casey@schaufler-ca.com,
        christian.brauner@ubuntu.com, christian@python.org, corbet@lwn.net,
        cyphar@cyphar.com, deven.desai@linux.microsoft.com,
        dvyukov@google.com, ebiggers@kernel.org, ericchiang@google.com,
        fweimer@redhat.com, geert@linux-m68k.org, jack@suse.cz,
        jannh@google.com, jmorris@namei.org, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        madvenka@linux.microsoft.com, mjg59@google.com,
        mszeredi@redhat.com, mtk.manpages@gmail.com,
        nramas@linux.microsoft.com, philippe.trebuchet@ssi.gouv.fr,
        scottsh@microsoft.com, sean.j.christopherson@intel.com,
        sgrubb@redhat.com, shuah@kernel.org, steve.dower@python.org,
        thibaut.sautereau@clip-os.org, vincent.strubel@ssi.gouv.fr,
        viro@zeniv.linux.org.uk, willy@infradead.org, zohar@linux.ibm.com
References: <20201203173118.379271-1-mic@digikod.net>
 <d3b0da18-d0f6-3f72-d3ab-6cf19acae6eb@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <2a4cf50c-7e79-75d1-7907-8218e669f7fa@digikod.net>
Date:   Fri, 9 Apr 2021 19:15:42 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <d3b0da18-d0f6-3f72-d3ab-6cf19acae6eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

There was no new reviews, probably because the FS maintainers were busy,
and I was focused on Landlock (which is now in -next), but I plan to
send a new patch series for trusted_for(2) soon.

Thanks for letting know your interest,
 Mickaël


On 09/04/2021 18:26, bauen1 wrote:
> Hello,
> 
> As a user of SELinux I'm quite interested in the trusted_for / O_MAYEXEC changes in the kernel and userspace.
> However the last activity on this patch seems to be this email from 2020-12-03 with no replies, so what is the status of this patchset or is there something that I'm missing ?
> 
> https://patchwork.kernel.org/project/linux-security-module/list/?series=395617
> 
> https://lore.kernel.org/linux-security-module/20201203173118.379271-1-mic@digikod.net/
> 
> 
