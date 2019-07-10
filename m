Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFD64B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 18:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfGJQzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 12:55:55 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:35186
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfGJQzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562777753; bh=W40o5XEMU4rCorrLR1kCtJCvcMpNySpd3aGGCzCSXcs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CDc1IrYjsWE/qtbUnYro8I/+BTfkRvDNb1wF4QcCEuSzhSuJRGjBP43cgwd4XzPJqZ0/8MHu7rmrUxh5znQbfb2xlt+YsjGitqYpcWmK+Tyq3TFBmjopXxPYspOuuimKYRUZEd7kXVuJCrCxw/RZx6tzSMXrK1n05OjrzQyGGgdylBSytaXY3WNvoWepq7GN4wZYH+jpAPqqfLxoFyRNpEbXuvmEEh2lW6bvpB/42hXWhyjzEgPqIwj24eUPZmPD7feE0GiwCpLRAne8CKAl6ltmV7q0Cp7piwPjuhCsT+qoHx79JE1fVM4/NPDbrrk2prfVSRIUNj1QYb71eLMn1A==
X-YMail-OSG: oc3Fne8VM1kq37MxuQgpCCYll33sv0UJXq588NmsUsGZEHYbRF5cEBvVGNLV1Ja
 v9VT5uHDfNLv88rW68YMalHfWgtANlQsLzBU6w_iHTwIAQxcWEFOj6K2P6MuEYsobEqpt4oxcTCv
 J72XLq3W8.tDKpHEVKI5opkdU5o6sTlfqBOmb1UhPTEhH29lmdCBnkQ2rdS13YVrGMj77Hc5DB03
 Eo77roP__V35tCKjXJHrLQ44gHavcMmxgee.U5qyG3H.yi7JF5Sepggba7VI7jzlmUv76_It8ao_
 nJBH4_g0ilIwzW.cEwe1tqMBK4VwtISFF5Wnph9sqA679GEd_M0YYuksR0F3MNl3Y.bzujcli.5g
 7FDEeYhpS8OVlQv7bLHap_hd7z7Ea9RUHfc7iNoPd3MEKspG.SLBRQdiTj2e7RNsbQMFpspstaut
 sm21jdR3obqNFkmK8OiR6foBVqfZarV49co.QvnAiwUfnQtcHGwLhpffeRiJ8Egr05PNEZWSJlcg
 3GFQ7NBObUADP_MKfr58fKB_AI1Z8lcoBgoeuc6_BWHZuQZukE2H2Yf0i2uaV59m_SCUPYtQ3PxO
 I0Ip.wIX5glSb1CAow_46qTf8QI9eL6963tCoqDBnN0j0OovFuRHRcJAoYw7vroHaP6l6WDncZj5
 tElhpYRILHuQlfOkuwYOOrZcImlMcSH6cmSlXUUD0ZUPEzz_IXOE0ve7kzUK7h8oizIgydXtZ_Hg
 7YnopjIzmpnLPRx03bGYcmOcsIF8JKufxbssH.Nu6xcoY6hxUeeHXLgRcvVexOcqri2jmrIJc8w3
 pG6sQjyw6_Of2uFqdnhz5.13dWQwUC7BJna5Uktm0CWLoOFU2eNRDYC0J0VIvbJSVSXMpjbIG9la
 p_0Li7YW9ZhVpyrX.X.5oMTbFB0i_yBOcjcVxmiydYewHWvlW5SbxPZUgNqwPJUTwXrPtzr7vQyJ
 1gbJBlyzS1k9AZ2kA7QL2t7q_imw0iG304ixt1LupxZWv43vopuLVFA81BKL0hwfN.t4gWsCSSdY
 xKpTvM45sgSl8Yc57YzE0ES8AOqXTIUTSDnR6jvH9L62yFwzDOfxP7het1iEIjz4a_wvw.g3lXt7
 DzKWFeMtrPZfgoIPerrU1mZaHgQu1dMZMlmpkGYBeR4rgE_C09JjXA0ysBVQteUtuajFbzQkWWrQ
 Z3jF9ap1AVTcxAE30zSNlarUrK0uQAtSmltTq5jn6iIoz2hRS469T56KkAJTpqwanvTIKA8J_rMd
 R08uwVqI95ALIbrKG3NPGONOdXdk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2019 16:55:53 +0000
Received: by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6255bb8bfa49d8f1a733324de6ae7414;
          Wed, 10 Jul 2019 16:55:53 +0000 (UTC)
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Randy Dunlap <rdunlap@infradead.org>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        casey@schaufler-ca.com
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
 <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
 <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <83818a21-ef3d-8c47-dd95-82272ca85622@schaufler-ca.com>
Date:   Wed, 10 Jul 2019 09:55:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/2019 9:49 AM, Randy Dunlap wrote:
> On 7/10/19 9:38 AM, Casey Schaufler wrote:
>> On 7/10/2019 6:34 AM, Aaron Goidel wrote:
>>> @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>>>  	return -EACCES;
>>>  }
>>>  
>>> +static int selinux_inode_notify(struct inode *inode, u64 mask)
>>> +{
>>> +	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
>> We don't use // comments in the Linux kernel.
>>
> I thought that we had recently moved into the 21st century on that issue,
> but I don't see it mentioned in coding-style.rst.  Maybe we need a Doc update.

Really? Yuck. Next thing you know M4 macros will be allowed.

>
> checkpatch allows C99 comments by default.
> Joe, do you recall about this?
>
> thanks.
