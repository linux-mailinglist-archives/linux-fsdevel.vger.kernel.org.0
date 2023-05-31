Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9A718A2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEaTbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEaTbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 15:31:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A2129;
        Wed, 31 May 2023 12:31:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256531ad335so3994995a91.0;
        Wed, 31 May 2023 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685561495; x=1688153495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkxhWE5ln5W4Ru3EpAV1+CbYcZ+ng9C+mZBukdpBf70=;
        b=DmH8jT8r2sbVdYY85iyMgz/6YVF4pjcmFqb1stRWVOdO3Ek+gFuBIiyf9jo4zjzoK8
         fWWKprto7SvFrm0n0LcPWJimjog/ZE72XzBvwpk2ungUqFyobEapCbLE07AvWfPqbc3I
         HHtq/tWX5cCM/P2VGqvyrc9jX7tVma6wHMxWGfndNO/aQhKS/LOWE03NEXLfSlLkdPKG
         QNFq8ZyfS304JWoCOcrTMSPDSEZyzz1PMBIvaJBZrnqazG0QYdqmGATHxmf79T3WxAE6
         vV6UnbncL962qEdb8R5XLVedFJtaGaiyjQ/LT3DAm9/S2HiX+8IaM4AbrVINatjqRnpY
         nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561495; x=1688153495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkxhWE5ln5W4Ru3EpAV1+CbYcZ+ng9C+mZBukdpBf70=;
        b=dZWztesnBLbriTvo9E+HVbgJfwwyUV+1e2FbdzgeJEHvLjp/N+tpajTPzFFxVi8AA2
         Mj2/13gm1cRHHmnY8GA4yr9BxewoBj9O0ekhL4lyoLOrgScB33FbHfSW79xGtNbjaHaI
         s8eYbS+Xi7K+5xE7an+LpiRJs1Jp1ohWiuvAtUO1qlsQ9UsDGrcmNYZKV6jsu7ZQcY2Y
         r2EYhoK0tS1WKTPYIVj+BI3aGzBaIi+yTnVi1eAjnUozNiZC4IDMtNKJgVsCKs+y4TWi
         kxLIgP8ROJTM/k6uSHL1Qp0x7XZNikz9QQizFKsOOttjDtP87TPK3M09g8sqsUo5wraN
         yskA==
X-Gm-Message-State: AC+VfDxS22YZf4zy1RXGnFTpfr4l2loD8T213E87UwJOPamc0icTGOia
        iAESegPFPMoYPGSjCu2peCk=
X-Google-Smtp-Source: ACHHUZ6jVcItk0IyYkAw2stDb0JLeHq82CItdIVJ98e8SlK5bQfxCD/QIJhdJUNTzgVVF8W87q5ULg==
X-Received: by 2002:a17:90a:2808:b0:252:dd86:9c46 with SMTP id e8-20020a17090a280800b00252dd869c46mr6470479pjd.31.1685561494987;
        Wed, 31 May 2023 12:31:34 -0700 (PDT)
Received: from [192.168.1.180] ([50.46.170.246])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090ace8800b0025686131b36sm1641165pju.11.2023.05.31.12.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:31:34 -0700 (PDT)
Message-ID: <97b35d43-337f-9cac-0a0b-86b216fce594@gmail.com>
Date:   Wed, 31 May 2023 12:31:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
To:     Christian Brauner <brauner@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        dchinner@redhat.com, john.johansen@canonical.com,
        mcgrof@kernel.org, mortonm@chromium.org, fred@cloudflare.com,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
 <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
 <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
 <20230530142826.GA9376@lst.de>
 <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
 <20230530-tumult-adrenalin-8d48cb35d506@brauner>
Content-Language: en-US
From:   Jay Freyensee <why2jjj.linux@gmail.com>
In-Reply-To: <20230530-tumult-adrenalin-8d48cb35d506@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/30/23 9:01 AM, Christian Brauner wrote:
> On Tue, May 30, 2023 at 07:55:17AM -0700, Casey Schaufler wrote:
>> On 5/30/2023 7:28 AM, Christoph Hellwig wrote:
>>> On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
>>>> The main concern which was expressed on other patchsets before is that
>>>> modifying inode operations to take struct path is not the way to go.
>>>> Passing struct path into individual filesystems is a clear layering
>>>> violation for most inode operations, sometimes downright not feasible,
>>>> and in general exposing struct vfsmount to filesystems is a hard no. At
>>>> least as far as I'm concerned.
>>> Agreed.  Passing struct path into random places is not how the VFS works.
>>>
>>>> So the best way to achieve the landlock goal might be to add new hooks
>>> What is "the landlock goal", and why does it matter?
>>>
>>>> or not. And we keep adding new LSMs without deprecating older ones (A
>>>> problem we also face in the fs layer.) and then they sit around but
>>>> still need to be taken into account when doing changes.
>>> Yes, I'm really worried about th amount of LSMs we have, and the weird
>>> things they do.
>> Which LSM(s) do you think ought to be deprecated? I only see one that I
> I don't have a good insight into what LSMs are actively used or are
> effectively unused but I would be curious to hear what LSMs are
> considered actively used/maintained from the LSM maintainer's
> perspective.

It's part of my job to look at functionality enabled by LSMs and how 
they can be applied to product security features and products at the 
distro level.

First of all the flexibility of stacking LSM's has greatly helped enable 
new and more features to be run at the same time on a Linux platform.

So there are feature buzz words out there, the main ones I'm familiar 
with,  like process control, anti-tampering/self-protect, quarantine, 
process injection.  The LSM's I've tried to follow w/respect to these 
features have included SELinux, AppArmor, yama, bpf/krsi, landlock, and 
safesetid.

Usually for process control ppl are most interested in killing a process 
quickly if its detected a threat.  In that end bpf/krsi LSM is a 
wonderful LSM for this and puts Linux on par with Windows and macOS with 
this feature (though the actual kill operation seems slower).

anti-tampering/self-protect is a mechanism to prevent say, an anti-virus 
program from getting killed by a threat process even if that process has 
root.  I believe this could be done via SELinux, Apparmor, maybe bpf, 
and maybe landlock.  In comparison, macOS does have this functionality 
via its Endpoint Security subsystem.

process injection would be a way to monitor a process which, yama would 
have to be turned off which then a customer would have to make a call if 
they want the protection of yama's disablement of tracing over whatever 
process injection feature the security company may be offering.

Quarantine is a way to sandbox a process that has not been determined to 
be a threat or not (unknown) and can be stored "for later (later 
termination or save-keeping for study".  That would be a neat future 
LSM, one I thought could be tacked onto landlock (but from what I 
understand would require the use of cgroups).

And speaking of future LSMs, I read one proposal I saw that I thought 
was a good idea called the NAX driver that was something like the the 
yama driver, only its sole purpose was to shut off the anonymous 
executable pages for fileless malware protection. But it didn't look 
like it got anywhere.

Some interesting usages/beliefs of LSM's I've seen:

*Using SELinux over AppArmor will help a security solution company win a 
govt contract due to the NSA relationship with SELinux.

*The belief lockdown will shut off or cause issues with ebpf, thus its 
not activated and used much.

*RHEL 8.7 having yama driver set to 0 upon install, which I thought the 
kernel Kconfig default was 1? So it makes me wonder what other distro 
installs set yama to 0 by default? Maybe yama causes an issue with 3rd 
party SW if its enabled to 1->3.


If you want to look at a security product making use of LSM's, check out 
KubeArmor.

Hope this helps...someone :-)




