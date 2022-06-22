Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A94556E70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiFVW3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 18:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFVW3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:29:10 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED942F023
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655936948; bh=dZC6eUKWDJPOTz/ILqg/qfRTRRpuLgPdjkd8hAWc1/Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gmA5qq8KBrWCdVlEiApeNXxhc7d26NhcZizNy2hTxaXzMAdBF7Pm+zzwAd+J04rb7xiUsRQuggGNLlQdBsYFth7QVxfZ1cvk9zlBrWgafE55gQgKuVqdapm3eqHpuVuuDA4Keir38vy16T5roVbsgMgVeVtIU9WgLzGa8k/sfNCcO+jmGwdGHTcIMzx4m4D6Fx8sQY0u4nzRdihhAlgKZ5MPUy57Gvrp83z0oD+S16u6zK78CA0Sx0yRoIYoASRhUQPMpUsYReJTwObuduZQjXMcxhp+5dKt71MCeKy6ZJHWTiOHXA9DKUa4lzXW3gBV83yhIeFvQMkFUdcVLzUzJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655936948; bh=eWvgXRw/NN9Soa6GuLG55pF5QCgnCTIj2Opi7yZiQ9H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VawDe6+LVHybt/oRwkcXYQviRKqUlss8RY/YPnDkrsXC54hKT2oo7lUamyL6z+91wRQcU5dsXLelKFJn0yODLt6BO+fRBmAvEsK0JzSkULmhVi6l+0cSx29AmQ8bVhpcv/b9qO8Hxg15n4thxyv1CwW71GTAl2eC9rg6kWLTHF+HtsNRxwv3FKmS1LqSVjV3yyTri1CxkWffPlwvRKjCQ5aZN16HkI6k2wqvuPJVo4MVP1Op2eOAHDSd+RRyFVL/v7eOZb4hLRRrjBfm7MJ6pZk0O9uYLu8WJBr9Gcyul9/Cwda1quYO8jvqltiPRzq34/U1bAtCQlTm2Upc8JmAaQ==
X-YMail-OSG: x72rNU0VM1nEYZaFdpF0mO.I7gF2rRQ4WqrLnJClgRUeN7S5lpig9biLmMI1dqM
 xx2i1dL5JGPVyEOqLlfgaEVf0JNMh5gtoHY3AtVJBfZ3wvhmQXMGNKC1wGSjElot2LDaX1reSvrG
 Nc8Ntl8MfqSP5PwJCQbA2SCaN62cKdboWAgzYuo7Jp0KK_fuCoWu1LSFRVPBgMRApIWRtbqXapNi
 hm1PFMO8x3JK.t40V8ZL9Fb9ZtQdE0soRWMsfgLhyehdcinj1SNFjKEAoDuV4Ku4Z94tjnc29UJH
 sjycwX0zheeUaJGWsIZiuERfBBhpRyxXhlCS1zvjwaKz5bKWQFgL6BxA9_7ne.4ukC_Ty3_.ZepB
 CUHPYAWaKiYJhW9fLlOU3Rxw3ksXccsi_r1YophLPv.oxGA2GoMO7WGT1yovCFrIDPlW.XXjuB17
 YM1HeiNcLTBV4T2hZxNQWQmMd8TfFAFfjQrbqe37XztM8yx4BSe8tIdorgZAKQlBNmMWd4USPlYI
 VPe4wZFDzsWCPgFKpdlXB4dxEw3mp_uu6Wx.s_4DPszkQ_VOLTcZfRNWHLhtAyxFyHeTFntdJSyg
 jYCz8.XeW.Ve.fosLlu6InV1uLkEvQRVwuIjN7Q5AIQrh5ZcVuSX2_fnEnTo6A4G6W4BVhbD1ex2
 f0rhxp27pDz.m5rvYbH8WRUPX2mgI5mU5eSsRCSlS5EUxULLgoTMMpcY0Ut9Phlla3Ibdd6r1CB1
 DfoZXIfSl1IQJKTVGd5mjwJ_Owrv8bTSz5Y4K7qQwCiGHw9FtjM4JogXIm4sKXtr8fpPRhLyfut0
 eAxQv9HDr1MJIjbhoAUTGLG2dxIxEb7z5iTVE42i9_3ke2E5f1Lbk8tlCjdKZeV959XXIVgl2W8l
 OWDpey49qZTW.iHRVbx4bv1OBxaMpaFR56Ymczk04TaDJNx1Bz7woC2AbgqS4xvufzSpJtKFyGFz
 yLwNHPOO3kk1N6dihGoA3wreDDJ0gpFi.AiOlgFPQsCbFpUTOAvw3x16g1tIocaIfmDNwLJnXjEj
 8i2LxaUrRh6_96mOS1ki9bXIqZpIUas3kWR68dJUDB0tmIwOYG8XOD3EKGjFW1LVsqXCbDAToxoR
 JvCPWGUwfTWaSZp4Ge_AvY8Xff9wP7OyuFaoFZ2agwlKOcXyQJR5mbxhNP5PrGg.1Wep3g1tv5AW
 Vr87U2MmeFoL4zF.mgJoMCYjk1fwwJH15.9sqjXmluUUq9MKq0EOEZgt6z8Y4O7C6YydjILezgcE
 VB426gpMht7VeA0Dy1_c_FME3mOhIfWkemP65OJDnRkY1bDTBgdkqEfzzjGgoDvdCKNR40J2QuJ5
 As83a6J4fK9z_eJzu18MQaiEPbBbtB0YqkCMPJKrnFLnu1g4wEUwS_div48o0Lz_fYhfwQ_gccjQ
 XwrYWPYHTzbUr54Knfyv59VTdeDfLIYpy9vWVtaD4Kghc67.8uyMa8YSB62A9xYe0ifVh2Vn3lUc
 rhVPJhz5b94tE3lHGDNWMTTjdYXkAVhfEoX0OH8kFBew74IOVTlSV6bIlP_ILHEQMHJr8FRiiBIr
 dHVxlTTY07kxaZUjf7Xk1.gOfRCcte4ynMEEQhHBYQ9Ru3z6rjOSKa8fk9cUs4sR3QWwbx6dAtZJ
 vpTKeKpyS3LSDenPo.YYGH.ZllD.T4kj2i_aHIYbx.9HQwvZ1dUebYTNN50XazgnQp1a4k1F3hRU
 zQU_qkp25XKFzgBehVSrA16kRsBEbZvbmNpNW78AIW1wxERQxC4Dsjx0Gem5SU4k1Wi3.5WqSonX
 S2tY1ckr5sJw44WgBtO4GH3B2krIO_KOAJYAC425FY6iJCF03.TI2jxr5ZGzFf4xDfcac4n.uXxG
 uU0X49ThlUAwj3vT5vMkZiNcKgv.xpa1Oq_q5RYZ63dv5p_lX2VHPsu8zm_It2pCIg9TY4LhdcnZ
 DIeSXwHeAKdESrASswRNTGY2irc.RGq0ZA.OKD.A4M0HDXMeo1u5JDtlIVMw9zMFzmtIBkv2f.12
 SyDk0wFRY81wdx9mdPFdj5GsyC040eMEEKeqce5aRkFhpHNAGe_mEZD0dcParvZNnlZpZ5s1P5Mu
 79uGXcrBVPN4Twq5E51IibEZgxWZ.u01LmjIwZzl8of4UlLLa0j0yePwwxBfOOHle5K7dM1bzdJF
 q8cpzfyobvhkq8qDvwKXU3isaaWRErmryWIWpZqYrEG_Aj.qthdDgZadVLUBG7_spxZutDMSMQiT
 Qo0pb.AzxdbOh1ExfblvSmmboJBPHHKSabQ2AR9lZ75Csbo0qcWQJ7Lz2b91mQHUgTd4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Jun 2022 22:29:08 +0000
Received: by hermes--canary-production-bf1-8bb76d6cf-xkxwt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4ef53ffbd9b7aee469fc3bb4f33f3a85;
          Wed, 22 Jun 2022 22:29:03 +0000 (UTC)
Message-ID: <e5399b47-5382-99e6-9a79-c0947a696917@schaufler-ca.com>
Date:   Wed, 22 Jun 2022 15:29:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 2/3] fs: define a firmware security filesystem
 named fwsecurityfs
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
 <20220622215648.96723-3-nayna@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220622215648.96723-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/2022 2:56 PM, Nayna Jain wrote:
> securityfs is meant for linux security subsystems to expose policies/logs
> or any other information. However, there are various firmware security
> features which expose their variables for user management via kernel.
> There is currently no single place to expose these variables. Different
> platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
> interface as find appropriate. Thus, there is a gap in kernel interfaces
> to expose variables for security features.

Why not put the firmware entries under /sys/kernel/security/firmware?

