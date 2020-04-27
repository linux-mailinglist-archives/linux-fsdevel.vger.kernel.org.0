Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B31BAAD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD0RMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 13:12:08 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:42189
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgD0RMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588007526; bh=kWCnVInj1Z999UWWV4XtFfIMcptgsFyR00nW3vYf3iM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=G27jjK80UBcO7V+hZTHH+i+gzSwx5KV9PWbKpe642SDeAFTAIiqXkyAIFONJonwt/c6btZA98siii6mKHCv+1tEakBrxdl27PY1nVnfnniBWKK5QJEkNxekUgX2AxWPmN3KnlAcCxi5fFU+QE8N5hOkxKNLR6RLybTpeSv7ebya9tqNpB3XsLvu33gFUnUg8QCHGE5mjyoQS4toFu0sJV9NedJySRxU50bTy3tgzbSMS5DH5JB+xzyxG9BrqntZxgagcRb7mBl5puD6OBIWV4vr2AhpUTWsobwCfSKKbsLN3HsB3UKwTwxPP17p+l6iCu4VhZpTQDgD/fFdkhRFecQ==
X-YMail-OSG: ZWxwGC4VM1niSneQjtR34yrJuJ7337p4s3DeG.7HDdhABua8wKGnUE4kxXCcLuw
 Jn0py7zyRorA3JZ49HY1QlmEDc4w0RA3fAUcX9WE16KMV41HvGBJColCrItlsu68AGl365SuEco5
 BRRAB0VQNJX7S440s3VoEYVDF65j2M3vwBf7SE3mCq3M8WRuIVgm0ky53JZo_T1IQLo1aceKrM9g
 3EQ44fam6uyLdcgUf2XYi_onKH8MnTRe1vdJXEIcPeuOgF9r1uOLJdegYYG1pqXl6kgOEC240M5F
 c48wOdcocWnFXWXDnFO08BbMyObpqicNJT6gf9sQ9tCZqX_tecGTF295vcccJUG_PhD7kiTw1lSR
 esJt4uVC05KPCq.mutaU0kxZH8CvjgrTTDaUcUaFdzTHsuDNQYbbHpXFY3O389RBa3AFgNag4C5U
 Z5uWYtDfzA0GeANzTO6aWt9gBl6bxZthZAaYJL.08e21THcHRHQom06tdfWzxlMYsP.zajRrauf0
 St79bZmLH5d59nZvaAtO0LrO8F96JNEmZErfjOCZyAL2pz.TWgfUQ0k0QLmPTdSByPV5qh1igtCZ
 YtzYU312QOgX6t5gNkQgvDHtwrn.08gnCoUuok9WJ8bG5fTO4EMi8SdLd1CHVSK6v1lSoDmbW7TH
 BX6PwR8ayoRbiRHTefpCtfSs6t5IeJXcCee2GldYDWCWgu1uydOPqxIPXskIniymT5sSHgGyL5t_
 M4WnkvVaYqDCWNGl6yP._IGazWXnsPy9ZDsSwP58Rd2_0JZBNyqi0Gs35y2fxS5YWVuC7DiLcydl
 wQAP7CJD2As_ZJi8cWF3.J2padoQ6LTAua2h5uKOzzgBZFLd86B8hXFn2KQfA7NNCzc15Iben02d
 2i4aEANknWyWJsbAEDq_6GI5Qvd0l8O9zjHP00gUM2ZtcJncNc_A79GfXpfReTlLbmqcYamwNpM1
 feg5kIwmtW0c_cH60_JLwmZaXTcG1XExomPIR3FE9s7xV.PgLDaAeLNz_tJ__m73t.5AOUlES9Oe
 acOaRMCpWVCiXSVpPQ4tfK09hLG5c2M2ck7L6pHO3ECosjK3u2wJTAnBfMrV2mrc.kjJJVU6_WMi
 obNC0wU_mDde0c0CB8IqhNYjBb6DHknjRUluAhtikaISs6p.Wy92mJYq8csCLYM260hEg0Je5LN6
 m9CIO_8Ifls_C10.KpyyMMNk3o7NBIsmaQlmMMB58CHOqYszVxoupnEDyzLV0VPxTekww53UtiMP
 vdqEZDe7V60T1ymyAbKooJBz8f74mwVEftG8S5xBJU3yT.kuop6NnuMCmCNdSllk4OZesjep12CT
 VbVeRLQ7k4nSIHjqWtqKbs3i_TldtfJ3GUBrDlPnTbvFPJrCvowChqL6UtCn_735QJaghRk2mHrf
 czZCDTZJL45ZxUHgIrbqUzp8lOmPM9pPUhiDZhyul5VXK
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Apr 2020 17:12:06 +0000
Received: by smtp413.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bec48a0bb590e327361ceae3e9ee0247;
          Mon, 27 Apr 2020 17:12:00 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        James Morris <jmorris@namei.org>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org>
 <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
 <3ffd699d-c2e7-2bc3-eecc-b28457929da9@schaufler-ca.com>
 <8bef5acd-471e-0288-ad85-72601c3a2234@schaufler-ca.com>
 <CAEjxPJ66ZZKfAUPnUjQiraNJO0h=T3OTY2qTVPuXrWG9va1-2g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0239869c-a00c-2e7f-f22b-73a3d58136c1@schaufler-ca.com>
Date:   Mon, 27 Apr 2020 10:12:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ66ZZKfAUPnUjQiraNJO0h=T3OTY2qTVPuXrWG9va1-2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/2020 9:48 AM, Stephen Smalley wrote:
> On Mon, Apr 27, 2020 at 12:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/23/2020 3:24 PM, Casey Schaufler wrote:
>>> On 4/22/2020 10:12 AM, Casey Schaufler wrote:
>>>> On 4/22/2020 9:55 AM, James Morris wrote:
>>>>> On Mon, 13 Apr 2020, Daniel Colascione wrote:
>>>>>
>>>>>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>>>>>>> Changes from the fourth version of the patch:
>>>>>> Is there anything else that needs to be done before merging this patch series?
>>> Do you have a test case that exercises this feature?
>> I haven't heard anything back. What would cause this code to be executed?
> See https://lore.kernel.org/selinux/513f6230-1fb3-dbb5-5f75-53cd02b91b28@tycho.nsa.gov/
> for example.

Great. Thanks, that's what I needed. I'll Ack the patch set.

