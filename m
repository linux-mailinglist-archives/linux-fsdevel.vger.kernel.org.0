Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7BFA3A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfH3PlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 11:41:21 -0400
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:23225 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfH3PlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:41:21 -0400
X-EEMSG-check-017: 19910871|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="19910871"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Aug 2019 15:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567179679; x=1598715679;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0BD40FUiWz6a0ni0oCrJsaBl2kWWx61EIcww3i0zvGI=;
  b=AADPPeKUHZuYNXAmtYlcXHKG/4ZfSEuDvmQ1AGq5TSIzJnbTJBmihiRZ
   66f0QYUPf/SodyDZkzXIgfSGXz+yuUeOfgkEBY9KeJPlDts9GFj9y8fMg
   3sUrOghGIVKgAPR9r7Y8+8JOrsyoEeWdHZth4Whx/AJdEO5jnIOcmXW0E
   033EUd316xDvNm0ZO6lFtVuC6fcRusM2LHNzmEubvJz0wREpWnZJCt0yW
   +o05dx8B9xe9Veav/pD1R5+POEQgJgF/r35+Ih1ej9z6Rk1QJDEkHK4Qu
   EZsPYtZWl2WSd6vE/GnczJp9rIIbtOe2Ubs7+klU4qIhSp2sXEBK/8buE
   g==;
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="32186112"
IronPort-PHdr: =?us-ascii?q?9a23=3AQW2cuBEgLS9uDm6gg0Ru8J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76ocq4bnLW6fgltlLVR4KTs6sC17OM9fm+BSdQsN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdu8gZjIdtKas8zg?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4slp?=
 =?us-ascii?q?scrUTDHijslEXwkKCWbVkr9vKt6+TmZrXqvp6cN4lqhQHiKqkih8OyDOsiPg?=
 =?us-ascii?q?UOQmSX4/qw2bL98UHjXblGlvg2nbPYsJDeK8QbvKm5AwpN34Y49hm/FCyr0M?=
 =?us-ascii?q?gYnHYbLFJFfwiLj47yO17UOvz4AvC/g0q0nDdx2//GJqHhAonKLnXbjbjhfb?=
 =?us-ascii?q?F96kBCxwo3ydBf/IlZCqsfL/3uWk/+rsDYAgUlPAyzxubtEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUGJ5uI1JOmBf44Utyj7K/gk+f7il3s5mV4bfam00pobcne4Hu5pI0?=
 =?us-ascii?q?mDfHrsgc8LEX0WsQomUOzqlFqCXCZPaHmoRKIz+DE6BZm9DYjfRoCimqGB3C?=
 =?us-ascii?q?m/HpJIfGBKE0yDHm3ye4qYXPcMbTqYItV9nTwcSbihV4gh2AmhtA/g1bVnIe?=
 =?us-ascii?q?nU+i0DuJLn1dh14fDTlB489TxzEsSd1XyCQHtonmMJQD822rpzoUtnyleMya?=
 =?us-ascii?q?J4meBXFcRP5/NVVQc3LZjcz+1mBND1XgLOZMyJREy7TdWnHT4xTs4xzMEKY0?=
 =?us-ascii?q?tmGtijgBHD3yy3DLMPi7OLA5k0+LrG33ftP8Z912rG1K45glk8WMRPK3Ophq?=
 =?us-ascii?q?hk+gjPB47GjUCZmLykdKgG2i7C6nuDx3KUvE5ESA5wTbnFXXcHa0TKrdT5/E?=
 =?us-ascii?q?LCT6SyCbQmKARBz9WPJbBQatLzkFVGQunsOM7Eb2KwnGe6HQyIya+UbIr2Z2?=
 =?us-ascii?q?Ud2z3QCEsanAET53aGNA4+Bii6o2/FEjxuGkzgY1n2/el9tny7VEk0wB+Ob0?=
 =?us-ascii?q?F70Lq14BEVj+SGS/wPxrIEpDshqzJsEVa53tLWDceApgV4cKVBetMy+0xK1X?=
 =?us-ascii?q?zWtwNjJJysNaNiiUAEcwRxoUzu0w97CoJakcgltHkq1hZ9KbqE0FNdcDOVxZ?=
 =?us-ascii?q?TwOrzRKmnv8xGjcrXW1U/C39aL4KcP6eg4qlX6sAGsEUot7mhn091L3HaH+J?=
 =?us-ascii?q?XKAxQdUYjrXkY06Rd6vbfabTc554/O0n1sK6a0uCfY2901HOsl1gqgf9BHPa?=
 =?us-ascii?q?OAFQ/yFdAaBse3JOwkgFimcwwLPP5M+64wJM6mafSG17CxPOp6nzKpk35H4I?=
 =?us-ascii?q?Zj3UKI7SZ8TfTI35kdyfGCwgSHTyv8jEumss3vnYBEZDcSHnewyCT9HoFRfq?=
 =?us-ascii?q?xycJ0VCWehPcK33M9yh53zVH5C8l6sGVcG1NWueRqIYFz3xRdQ2lgPoXy7hS?=
 =?us-ascii?q?u4yCR5kzUorqqZwSzPzP3uewEDOm5MWGZijkzhIZa7j98ERkikdQspmwW/5U?=
 =?us-ascii?q?b82adboL5zL27JQUdHZyL2NX1tUrOstrqeZM5C8JcosSRRUOShblGWU739rA?=
 =?us-ascii?q?UA0yPlAWRewCs2dy+luprnhRx2kmGdI2hprHrfZ85wwQ3T5NvGRf5ejXI6Q3?=
 =?us-ascii?q?xUgCfWChCcOMak+dGP38PPsuehWmalTbVJfCXrxJ/Gvyy+sz5EGxq6ysuvl8?=
 =?us-ascii?q?XnHA5y6iry091nRG2ctxrnSpX63KS9d+R8dw9nA0GquJkyIZ13joZl3MJY4n?=
 =?us-ascii?q?MdnJjAuCNcwGo=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6CgD3Qmld/wHyM5BmHgEGBwaBZ4FuKoFAMiqEIY8LT?=
 =?us-ascii?q?gEBAQEBBoE2iW+RJgkBAQEBAQEBAQE0AQIBAYQ/AoJgIzgTAgsBAQEEAQEBA?=
 =?us-ascii?q?QEGAwEBbIU6gjopAYJmAQEBAQIBIwQRQRALDgYEAgImAgJXBg0GAgEBgl8/g?=
 =?us-ascii?q?XcFD60lfzOFSoM2gUmBDCiLeBh4gQeBESeCaz6HT4JYBJVCiA2OQIIpgieJU?=
 =?us-ascii?q?YhZBhuYYi2oGCGBWCsIAhgIIQ+DJ4JOF44+IwMwgQYBAY4rAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Aug 2019 15:41:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7UFfGwf014909;
        Fri, 30 Aug 2019 11:41:16 -0400
Subject: Re: [PATCH 10/11] selinux: Implement the watch_key security hook [ver
 #7]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <21eb33e8-5624-0124-8690-bbea41a1b589@tycho.nsa.gov>
 <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717352079.2204.16378075382991665807.stgit@warthog.procyon.org.uk>
 <13308.1567176090@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <87de7cc1-435e-1b56-afec-bc041c193317@tycho.nsa.gov>
Date:   Fri, 30 Aug 2019 11:41:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <13308.1567176090@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/19 10:41 AM, David Howells wrote:
> How about the attached instead, then?

Works for me.

> 
> David
> ---
> commit 00444a695b35c602230ac2cabb4f1d7e94e3966d
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Aug 29 17:01:34 2019 +0100
> 
>      selinux: Implement the watch_key security hook
>      
>      Implement the watch_key security hook to make sure that a key grants the
>      caller View permission in order to set a watch on a key.
>      
>      For the moment, the watch_devices security hook is left unimplemented as
>      it's not obvious what the object should be since the queue is global and
>      didn't previously exist.
>      
>      Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 74dd46de01b6..88df06969bed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6533,6 +6533,17 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>   	*_buffer = context;
>   	return rc;
>   }
> +
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +static int selinux_watch_key(struct key *key)
> +{
> +	struct key_security_struct *ksec = key->security;
> +	u32 sid = current_sid();
> +
> +	return avc_has_perm(&selinux_state,
> +			    sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
> +}
> +#endif
>   #endif
>   
>   #ifdef CONFIG_SECURITY_INFINIBAND
> @@ -6965,6 +6976,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(key_free, selinux_key_free),
>   	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +	LSM_HOOK_INIT(watch_key, selinux_watch_key),
> +#endif
>   #endif
>   
>   #ifdef CONFIG_AUDIT
> 

