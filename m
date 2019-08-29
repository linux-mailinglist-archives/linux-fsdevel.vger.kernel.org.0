Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CDAA2674
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH2SwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 14:52:01 -0400
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:63495 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfH2SwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:52:00 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 14:51:56 EDT
X-EEMSG-check-017: 9724769|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,444,1559520000"; 
   d="scan'208";a="9724769"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Aug 2019 18:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567104278; x=1598640278;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OJno2unw7GNcFP9xCwEixiBrvxzKpwTt2h9Zbf0y1Qk=;
  b=mfw8OrEmukiP5hsgIENCGF74D8KsSw2omCcBN+CCo0xa9HYw7+BS0ctL
   RGAvCUng98pLOhTZYnBaOpdSB3Nou6J/dAN6FFKsUte4KX4q7fz09Ip2C
   t6UXQdKSwzuxoHbmcXaDmFz/4l4AdKioZnQdy33LrB5K106RUlM1uKFOT
   ltNq328QuijPUX+FDXCfuC/VGMX4+NCp+6VmABNuQkQBR8oGHD1GK8gy0
   YXHwAOLXyHMt5vI4gASohsh9osi7jqlmZlOvJ3lQO+GpytSFbvpPIdTCz
   yjhFurWSdw2SobuSpl1J/hFU+u4P17xxahK3pfwEBadS3w2jOJUu6jJG0
   w==;
X-IronPort-AV: E=Sophos;i="5.64,444,1559520000"; 
   d="scan'208";a="27348082"
IronPort-PHdr: =?us-ascii?q?9a23=3A0dXRBxzQQ6WU8XnXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uwfKvad9pjvdHbS+e9qxAeQG9mCsbQd1bCd6vq6EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rBvdusYLjYd8NKo61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3fekLfher?=
 =?us-ascii?q?h85FBYyAo31tBS/IhUBa8cL/LzQEDxqMbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKL3SsV6S5uIoOOSNZZEauDD8K/g7/fLuiX45mVkAfaimx5cXb2q4Hvt8L0?=
 =?us-ascii?q?WEYnrmms0BHnsSvgoiUOzqj0WPXiJJaHapQa095io2CJm6AofDXI+tnbKB3C?=
 =?us-ascii?q?OlEZ1Mf2xJFkqDHW30eIWDXvcGcDiSLdN5kjwYSbihTJcs1R60tADkxLpnLe?=
 =?us-ascii?q?rU9zYctZLi0th1+uLSlR819TxpCcSSznuCT311nmMPQT86xqd/oVZyyl2by6?=
 =?us-ascii?q?h3n+RYFcBP5/NOSgo6M5/cwPB9C9D2QA3BZc2FR0unQtq6ATExUsw+w9sVbk?=
 =?us-ascii?q?t8FdSijxbD0DewD7AJkLyLAYQ+8rjA0HjpO8Z913HG2bE7j1Y8XMtAK2umi7?=
 =?us-ascii?q?Vj9wjTGYHJll+WlqiweaQawiHN6H+JzXCSs0FATA5wTaLFUGgDaUvWt9T551?=
 =?us-ascii?q?jCT6OvCbs9NAtM0tWNKrFQZd30i1VJWu3jNM7fY2K2g22wHwqHxquQbIr2fG?=
 =?us-ascii?q?UQxCbdB1YEkgAJ/HaGMwc+Bjy6rmLAAzxhC0jvb1nv8eZgsnO7SFE7zwWQY0?=
 =?us-ascii?q?1mzbq19QYfheaARPMLwrIEpCAhpi1wHFa82dLWFtWBqxN8fKVHetww+0lH1W?=
 =?us-ascii?q?3HuAxnJJCgLL5thkQYcwtpu0PizRJ3Cp9PkcIytnMl0BJyKb6E0FNGbz6Y2Z?=
 =?us-ascii?q?HwOrvKKmj95RyvcLDZ1U3D0NaM+6cP9PQ5p0zmvAGuC0Ui7nFn3MdO3nuC6Z?=
 =?us-ascii?q?XFEhASXYjyUkkp7Rh6oa/VYi0n64PTz31sPrG+siXe1NIxGOsl1hGgcs9bMK?=
 =?us-ascii?q?OFEg/yDsIbC9GgKOwxhlemcAwEM/5W9KMvIcOmeOWJ2LSxMOZjgj2ml2JH75?=
 =?us-ascii?q?550k6W8Cp8UOHI1Y4fw/6ExguHSyv8jFC5v8DzmIBEYywSH2WmxSf+HI5RZ7?=
 =?us-ascii?q?Z/fZgECWiwOc273NZ+iID3W35e6lGjA0kK2MizeRqdd1b9xxFf1VwLoXy7ni?=
 =?us-ascii?q?u11zh0kzAvrqqC0y3C2v/tdB4AOmFXR2lvlknsIYeqgNAARkSobBYmlAGj5U?=
 =?us-ascii?q?nkw6hXvqN/L3PcQU1QZSj5M3liUrestrqFe8NP7JIosSNKUOWzeFyaSaDyow?=
 =?us-ascii?q?Ec0yz9G2tT3y47dz60tZXjhRB6i3ySLGx1rHXHfcF83xDf5MbTRa0Z4j1TaC?=
 =?us-ascii?q?BmiDWfJl+jMt2t5p3Am5fEre26U3mJTJBfcSD3i4iHsX3/rXNrGxqXjf21m8?=
 =?us-ascii?q?OhFQk8zD+90MNlEzjL/zjmZYy+7Li3KeJqeAFTAVb478drUtVlnpAYmIAb2X?=
 =?us-ascii?q?9cgI6cu3UAjzGgYp1gxaviYS9VFnYwyNnP7V2ggRYyIw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ClCADBG2hd/wHyM5BmHgEGBwaBZ4FuKoE/ATIqhCGPC?=
 =?us-ascii?q?E8BAQEBBoERJYlukSUJAQEBAQEBAQEBNAECAQGEPwKCWSM4EwILAQEBBAEBA?=
 =?us-ascii?q?QEBBgMBAWyFOoI6KQGCZwEFIwQRQRALDgoCAiYCAlcGAQwGAgEBgl8/gXcUr?=
 =?us-ascii?q?Bx/M4VKgziBSYEMKIt3GHiBB4ERJwyCXz6HT4JYBJU+lkoJgiCCJolPiFgGG?=
 =?us-ascii?q?5hdLY1CmkYhgVgrCAIYCCEPgyeCTheOPiMDMIEGAQGPBgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 29 Aug 2019 18:44:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7TIiXHa013542;
        Thu, 29 Aug 2019 14:44:33 -0400
Subject: Re: [PATCH 10/11] selinux: Implement the watch_key security hook [ver
 #6]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <156710338860.10009.12524626894838499011.stgit@warthog.procyon.org.uk>
 <156710348066.10009.17986469867635955040.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <03eb0974-3996-f356-5fbe-17cf598b0e31@tycho.nsa.gov>
Date:   Thu, 29 Aug 2019 14:44:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156710348066.10009.17986469867635955040.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/29/19 2:31 PM, David Howells wrote:
> Implement the watch_key security hook to make sure that a key grants the
> caller View permission in order to set a watch on a key.
> 
> For the moment, the watch_devices security hook is left unimplemented as
> it's not obvious what the object should be since the queue is global and
> didn't previously exist.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>   security/selinux/hooks.c |   17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 74dd46de01b6..371f2ebc879b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6533,6 +6533,20 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>   	*_buffer = context;
>   	return rc;
>   }
> +
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +static int selinux_watch_key(struct watch *watch, struct key *key)
> +{
> +	struct key_security_struct *ksec;
> +	u32 sid;
> +
> +	sid = cred_sid(watch->cred);

Can watch->cred ever differ from current's cred here?  If not, why can't 
we just use current_sid() here and why do we need the watch object at all?

> +	ksec = key->security;
> +
> +	return avc_has_perm(&selinux_state,
> +			    sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
> +}
> +#endif
>   #endif
>   
>   #ifdef CONFIG_SECURITY_INFINIBAND
> @@ -6965,6 +6979,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
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

