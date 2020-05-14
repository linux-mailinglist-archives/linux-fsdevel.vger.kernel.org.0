Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E141D35B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgENP6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 11:58:09 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:40186
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727802AbgENP6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 11:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589471886; bh=lJfqCN099Mb/d5ojj5Nm59+7L4ICZfqVdceuNiAe6iU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=AwPGAJS+tjHS43tR0ADM9VPjxCISoS8Qi/iGUfpPobm0/ghSl/5b+i5PhRy6Du/wOcfziASUvrQ3xu6EtjBcdy0H+GYgAedX7fQcjYCcCYQ80YxpGJGMOwH62q166MrTisOgQVtpqAkDXOJlrmcXaE/Np9x3nElSTdOuJ3JxQxxVjcMg6KW4+QHTFnjhKtQYnOFGMk0hEpaokZyEAKgXp4owX79w29KW2tKFYqOl2u6J1e5q4rkXBI8lgdFaF4u8+9mwiu6jjV2fQrvH1dspcaoQ9k3bUWaS/9rv6ciiVgg3zVE9nggo4jvKHo/dpDu+pstGCCaCjsP8rIlZ0W3AFw==
X-YMail-OSG: TL2Hmq0VM1lCEVKkmqdbc1i.iOnNwL9OyLISaMlPR8GJwJHLJgjAQRGc5elTEU1
 c37wz3Ap7HzZjUq5qOeycqG9Jn.649DteV_VPr8HddjlPUT4h_b8VbAevHTolBnN2IAvV_cTt9kB
 HNEqe7aalAyWZRpv1AiDE.Fcmm6zHZRDcySbPG3cF8fuKURVqBtcvJ4sueNwU2MgTOeyI5b8P83L
 OUZ9WJUcDCXP4B.z2kVNsJA6ax6RayAXbrpoFbL7Uk42S_rlkdsXhKms5JBKtcOruHpbVp6_mWgh
 bp8yROUQkkT3GxuJgHUviOjzulJuR1MW_I6QgKVZtzBj_GHBRArYlTD6t2ymF3XBIWTGveU4uQ1I
 iiNn7YCQPCUUJIo1aAH2zOzwNuySUf21t4IPsGjuwaCDpKOFDeZNQjNADltrVc82yx8gdlttFNdB
 wFh89hEfc5ZEQ2FATYDEshEmKzlPeAQ6VAC0HQ1jdf.O5IUdOGkE8bvMXT48p4s8iGoKKJFvLY5d
 hs2uuCrk9b4.riL.Py0GkcZgNnJ68qH3wXsQRGJH90zAC.JkfCpHlQVtkcjpe1VsExrnjM3Vaz7t
 exWnmXi4JF5BlpYW4chOs9HsAWwWSym4jiXru3tHdMowBR6_L6gjI6XP_Ye_liUXFnYZbYIq9Fed
 sQKREodyjAEw48o3AzOlD2YtDQKWG542ykBov4KUWaiwUvl5zocxqIDZzF29Hf4zEAlWVBDrtsJW
 urUy6X3eJOIFxaunUloXSMsUiT3CHQMkA7Spw809boBmGQorD7Ie9grUOBC.jw_8nwV1KxY4v5Yd
 frQO2OveB0We_p7FMcurUJ.9mHvoF_Phsyt11eYEI5uKcM32nYBWXFosnuYcF.s__q.wbPHws.RE
 hHRK9MJz24bU78JbKIP1Iu1KwdW7nYr1KPOV.tTxnJrazapeyWLre0PA_Lte0uUl24Adt5s9mc0r
 sBb6TSXdBI2bf0wboH1_1OYCNbqKe.XV1GYCIT1IZcExEMHqbaR2YOY7XQRz8U.9F6SAcrakIjLd
 Q6_4fOCv_mN9AEYJJcj_UiLRFDJ8MwhBLPcTM0e5e24d5iUTw70s5hGTIG266lvVWY9g3LCTnMMh
 CGtqsx9aogVT44V..lDngW7CPeQ6VDnIuTkAbUSaS7P4Ztv8ydqAV_Mc5fkCUD16I5fl83iTYN1V
 43335SA7PQgXiue46A5.g7_bTEClCv8mUrBOAcn_kg7D96mJklMRjdcYZmx9H1N0aJzqk7qKgrxD
 .dnKqDrlW7iDVEcfYBgyilvRBazPyQANEXdrJzMXpD8IgEyf2.ELmImNSNcYCLlNDYVXfmEZgD5V
 h9zsl3tjJQHRJD28XS_XjAiDPlqVEfyCecfoQlLbrUj02TaBTbb5fh.VNrEnhKTI.bo4e63UUpFe
 pYO3hNJTrdvZyw1fOr00uku7uZk5BQoyYK0VWFkGP_RNMiUfw5PLUSd1PXtEPKnah7gJ3vl_yfuD
 VtExuDPw8dyZo20QhPlAZJBRUHmiQ0z2NqCRqyl8W0QPK_rWxWxfuQQQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 15:58:06 +0000
Received: by smtp419.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e3935901ce24bb77d4947cc41492c6c4;
          Thu, 14 May 2020 15:58:05 +0000 (UTC)
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem access-control
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200511192156.1618284-1-mic@digikod.net>
 <20200511192156.1618284-6-mic@digikod.net>
 <alpine.LRH.2.21.2005141335280.30052@namei.org>
 <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <bcfa8f74-5bc9-b363-5372-b254ba2e88a7@schaufler-ca.com>
Date:   Thu, 14 May 2020 08:58:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15941 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/2020 3:39 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> On 14/05/2020 05:37, James Morris wrote:
>> On Mon, 11 May 2020, Micka=C3=ABl Sala=C3=BCn wrote:
>>
>>
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 45cc10cdf6dd..2276642f8e05 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -1517,6 +1517,11 @@ struct super_block {
>>>  	/* Pending fsnotify inode refs */
>>>  	atomic_long_t s_fsnotify_inode_refs;
>>> =20
>>> +#ifdef CONFIG_SECURITY_LANDLOCK
>>> +	/* References to Landlock underlying objects */
>>> +	atomic_long_t s_landlock_inode_refs;
>>> +#endif
>>> +
>> This needs to be converted to the LSM API via superblock blob stacking=
=2E
>>
>> See Casey's old patch:=20
>> https://lore.kernel.org/linux-security-module/20190829232935.7099-2-ca=
sey@schaufler-ca.com/
> s_landlock_inode_refs is quite similar to s_fsnotify_inode_refs, but I
> can do it once the superblock security blob patch is upstream. Is it a
> blocker for now? What is the current status of lbs_superblock?

As no currently stackable modules conflict over the superblock
(SELinux and Smack are the existing users) there has been no need
to move its management into the infrastructure. The active push for
stacking does not (yet) include everything needed for SELinux+Smack.
It includes what is needed for SELinux+AppArmor and Smack+AppArmor.
That does not include the superblock blob.

You can include a patch in the landlock set that provides infrastructure
management of the superblock blob. Feel free to glean it from my proposal=
=2E

>
> Anyway, we also need to have a call to landlock_release_inodes() in
> generic_shutdown_super(), which does not fit the LSM framework, and I
> think it is not an issue. Landlock handling of inodes is quite similar
> to fsnotify.

