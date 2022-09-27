Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949425ED11F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 01:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiI0XiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 19:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiI0XiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:38:02 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882321D1E1E
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664321879; bh=dcoJeyML+0RbcNiEVPffEvxaFIftFIaaNOl8mKiOxH0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RcChjhewUU/yqn7GWVsj8OZ8sB/qzeclFs49E+iEtpqv6EWP2wwjwKjYOuZktksHKVvANTMu+gB3Mys3cBESqCwOA4eVqV8CyfpQAN1/jNH7hrrDMYyX5pxV+qa8bocQTOD5J+cEHQBtzBMm1XqWnPFw12RODVyQ0/u0YGgFCZw2FiLbpoquJD99C7j/p7v3TuJlQDZY1S3/89qhy6S5GKe++2MiknR6MY0CGJo2UEykoJfAEjuYi1R17JRHaTPF8+C1GZy7no3V3Vgd6SUTD1DNiAGkt0FoQodWaYM2EqMtN/YNcpLErv0LbtRCxjPgpfDormH1VCxc6MfUBVX46Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664321879; bh=Ik0PYjOuc7lxbFxdO2yAjC6eVPf0i0AdrVbA0qtDBB7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Kiv+wprQoXOI55JIkEzkSiEaFr9gS3j7FKE1Sy91BR96//PoleU09LKMqx0LJ5VKCB625cZOYrXI9PIcau61JcdfSh60STrOjq0qgIMBjC2059yYuhB3jLOLVG1lWADYui1vTOJ8iviVuvN0s2ykHU3bH9ZwGubEJ90i5jL9xdhFed55EqPMtvQaJcJu7wwznFkumugLUvs7En85Ybw/KnHGAG1vP/8FLR2VQvBN7ZngasGFhfuKfPsSI2iN7P1BJZOkwDbuGe9hmjfII8d+eTD6dx8KfvAKcqOrJNnDXhhA+r04sfM28T+HlcG0eNyQZfLFOc/OUR3ejpvH67CdmQ==
X-YMail-OSG: 9FZcd74VM1nIsnhlS8k4XujrMNRf1tm5BWXhXDB8Y50igsqWYSobkypOn8FrM3q
 _hPfMuom8fVjihzlQCab0E2bPurfrZz_GSBhFUrQv54hTgazW7A9QcEozzE8Bv4VzN2wOJcPorcx
 NQOu4WuLC.XOkH6dSyFeMrxtr49_2b0sHnwQzs602nD9TdFeXhoAw8g_2cq9tSzI9Dtr5TxFqLPv
 N58LBY8zPILuFtTLs_AVwbyc6pkF.I6APGoxJKa59.e563qGsZi0KpQyS.oiZzTI_ut1UcOkjeEq
 GhkBwwI_X80cvyi6mPeHuaHEfhbLvqwe.puoJT1ST.V87NbbgK18R.OEOPzkPjL5IX5KouTDdqS7
 MGQeGNLPFx1tusGUDO1EjRPOZEzUQwjHLW_c.URdmC7xpzOHxMCHle7QEdzQNYiRMsygNWg6qkkf
 1g_vdmAFk..iwfHJlDj6YggUMr9y.hH1YpthB3FZnnzIWlGDw0ExNakQ0SqH2cXhWKte5CJ8cIFh
 4B_TqSveZ0wDoRK9gy7En8_9eftyeh3NRI_A4DlM4XaDvY6Qy0JmJ64Ehcip.YtdviOb3GNZcwx_
 edpc0gkdYpAuk7enZ1sncc1pN87Fclcm7irdaaU63XeK3C47t_3pZBfMr3F2G4WbHIq.7h4I68fZ
 pmCGRlzmmSluk9QsqxKyjv5e21JHCckNMq96ULDOdMj1sUN6IE4VPJtO8c6fmVrsx_9F8ZQsjR62
 YBU4cxj5QyuoGO7nuMnxLcR1pvEXm.0c0n5KmkR_smUFwRZr8vTFvyQrNQdNcqcynZ.HALYKfl47
 iFHWXiNh6ddGHhSPWnWhcADNXrWegcxpBTLIJSF98XZlH1ri.teIb0djfeEv7K1l9Vytvy5QrbGt
 RMdZjctj5L0OX10RCBSk3xhB3qY9gsM4pCuDCPrSl3_rlfUj8Ql.R9Aj9v2nzOMGxd_IL4YBa99r
 L6KwnWNJn6FrwbAjsbFgUMO2ql_Sw5IQREHZsTbtQY1X_T7oplSYBibjkVSh8Qypo5Cej4I3i4on
 JfI1DTsGoOtBZA6rqcAigMA8KroFnoDe6pZUPErAiYqFHhxoliRYnMcPJCAgPVqSm5cH0dGgobdD
 Z6glosu.vhnnISjsV7vYuO343DrGG.bCy1xHXsxMQJwZEEDDNFg0XrDYcJIPeIVwHveWJJD82pLD
 yBRqToFG1OyPiCL8CpX1q2fJYuOS39CsAoamXjF7Mp7by71A7nzNF_RJwU5EjSipSmDNkTa_oT0K
 wFprPzbfWdxPmsFlVc75F6DB4It2JEl9xRb0J0Wa9odsJgxtLzj6UKjth.eieUldQgz8g.FJga8A
 aV9bSdift_fqYcsGXbS2SFmOeH3q4NE45WtH5VCa7hbDhPYc8Jxhi3RKAsNpzV2IH7puodtqx2MW
 mPcyybNoje4lnkD6yxwVgzlgNDbh3.0Bi4UzB5qoFkjbkmHvMI7JuakBBCm.yJn.BcXHjz1pdpaj
 zayojCB0VOE.pil0xBT0kwQWRra5mNVuJI7YA5iOCdOrYugcEKLYNdnHOVdNjV.nSnBYfjs4tOPv
 0.fSK5DjyWm8eK8_hPz6ZFNVf.5BynwY6xgado5tbWWlNc_vJY1m7C_HeFrUhHMjhj9YBg1bmUIR
 .EA6QBQslhUwZXCjuaryQlDhZvbAXvsQ.JTYTjMSQcc3IgTaufqAvREHdANjgGkP3FCPI948YaE_
 MbwkO3E5y3PurbgJNGMOXo4LGVxNb4BWFIVc1w7yAPvx_vEBoPUF2EvvpNBwOTyoFNhdvcbPiSbH
 vkXAqcoNQHOlP5xdhSBcIs2I7rPKZ13oOyGsraJ9ULzapO9NWbHkLTZji84FsvMOW1IeMvq_YrE1
 o9Gh9yZCzirOgWbS1p7nBj.LIooDvTPrmv1vqIL.gRLODOg_3ja9TwL2i_FPXH6EBcFvTf2JZH.J
 c068T8niVYx0O.X17grb95y5PKLbTaeyYW8Nrd2Pmr77oLoa8_njRFcUEaSfQMAA1xrK50eOaMqK
 rB_w9oZL6pBd99T9sX_2QLnBp_dqaepGzNmZ.TwVzMsT51xfvz8WO8u66UFx3XkteK0fARQziNUi
 gPwIxGGisRqbveqtsACwVofSi7abZAU2Y5VPjFd_BUMLPTewNfpUX6AbYVLs9YQWbJs8qQIB9cHk
 O6hfKnnQGNL5X6.wg9lZ78AObU9trTk5xnyDoiFnQin3phl0NaIZHr.W9fQYK6w6BmPVk5MkdRPa
 O94129SQoL18H3Uw4x1E44jqXy3zmJL7Xv0JPIKyU0fVxZdC7MDjXj7FPlQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 23:37:59 +0000
Received: by hermes--production-bf1-759bcdd488-x5z77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1ada386b527abdaae554e50e8733736f;
          Tue, 27 Sep 2022 23:37:55 +0000 (UTC)
Message-ID: <6dcd0fe7-3fc6-9edc-349c-0133ab1f918a@schaufler-ca.com>
Date:   Tue, 27 Sep 2022 16:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 00/30] acl: add vfs posix acl api
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20220926140827.142806-1-brauner@kernel.org>
 <99173046-ab2e-14de-7252-50cac1f05d27@schaufler-ca.com>
 <20220927074101.GA17464@lst.de>
 <a0cf3efb-dea1-9cb0-2365-2bcc2ca1fdba@schaufler-ca.com>
 <CAHC9VhToUZici98r10UJOQhE48j-58hUheT0P8GE9nC38p=ijQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhToUZici98r10UJOQhE48j-58hUheT0P8GE9nC38p=ijQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20702 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2022 4:24 PM, Paul Moore wrote:
> On Tue, Sep 27, 2022 at 10:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/27/2022 12:41 AM, Christoph Hellwig wrote:
>>> On Mon, Sep 26, 2022 at 05:22:45PM -0700, Casey Schaufler wrote:
>>>> I suggest that you might focus on the acl/evm interface rather than the entire
>>>> LSM interface. Unless there's a serious plan to make ima/evm into a proper LSM
>>>> I don't see how the breadth of this patch set is appropriate.
>>> Umm. The problem is the historically the Linux xattr interface was
>>> intended for unstructured data, while some of it is very much structured
>>> and requires interpretation by the VFS and associated entities.  So
>>> splitting these out and add proper interface is absolutely the right
>>> thing to do and long overdue (also for other thing like capabilities).
>>> It might make things a little more verbose for LSM, but it fixes a very
>>> real problem.
>> Here's the problem I see. All of the LSMs see xattrs, except for their own,
>> as opaque objects. Introducing LSM hooks to address the data interpretation
>> issues between VFS and EVM, which is not an LSM, adds to an already overlarge
>> and interface. And the "real" users of the interface don't need the new hook.
>> I'm not saying that the ACL doesn't have problems. I'm not saying that the
>> solution you've proposed isn't better than what's there now. I am saying that
>> using LSM as a conduit between VFS and EVM at the expense of the rest of the
>> modules is dubious. A lot of change to LSM for no value to LSM.
> Let's take a step back and look not just at the LSM changes, but the
> patchset as a whole.  Forgive my paraphrasing, but what Christian is
> trying to do here is introduce a proper ACL API in the kernel to
> remove a lot of kludges, special-cases, etc. in the VFS layer,
> enabling better type checking, code abstractions, and all the nice
> things you get when you have nice APIs.  This is admirable work, even
> if it does result in some duplication at the LSM layer (and below).
>
> It is my opinion that the impact to the LSM, both at the LSM layer,
> and in the individual affected LSMs is not significant enough to
> outweigh the other advantages offered by this patchset.

Hey, in the end it's your call. I agree that cleaning up kludgy code
is inherently good. I'm willing to believe that putting further effort
into the patch set to make the LSM aspects cleaner isn't cost effective.
If everyone else thinks this is the right approach, I don't need to
question it further.

