Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF6103ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfKTPfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:35:44 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:44664 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfKTPfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:35:43 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 10:35:43 EST
X-EEMSG-check-017: 50252330|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,222,1571702400"; 
   d="scan'208";a="50252330"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Nov 2019 15:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574263713; x=1605799713;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SbonHAnJ65ofoJGSPztdBnhiqK+qDwU/5hUGN93Jeiw=;
  b=P6DRL/oM82D31nXN10/RnZ3dcJRSsuTJnyFKM5QfsVvUcIJkqtSaElep
   LNdEa/9XSPHMzsAi0J5lgvmOnAW9UKdHmALO7xmCKkXy9imCXpJJ6a8Sv
   G/Esb+ufPg+mJdayrn86vsHbS0CQTXPdEGpws79hg4LAAlQsS+OfNdCHI
   3gIBPb8Chl3LHmHQudtdmfMUWTpmoyXKFMJ8XlTanUtGTIdh4UqTNCvsU
   QqUti9QSNzEuinypc3+qZ7jh9Mxy7sJZIKgS93Nf6mAt5WNUtmjKJUlHq
   WavCjbL4uZN/xCDebUHm9063g35wopgdLolsssej/tfYdJ9+ey333IMXh
   A==;
X-IronPort-AV: E=Sophos;i="5.69,222,1571702400"; 
   d="scan'208";a="35774017"
IronPort-PHdr: =?us-ascii?q?9a23=3AqI7KQRVBRCbj8kIN7jKsyLGYakTV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRWGvadThVPEFb/W9+hDw7KP9fy5AipZvM7K7ypKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMLjYZiNqo9xR?=
 =?us-ascii?q?nErmVVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhBOfixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?h8609YyAo31t1f5IxbCqsHIP3tXk/9rtvYDgU2Mwas2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZK73dsVuJ5uIpPumNa5QYuCjyK/c7/f7il3w5lkEHfamvw5QXbGq0HvN8I0?=
 =?us-ascii?q?WWeXDsmMsOEX8WvgoiS+znkFmCUT9VZ3avUKMw/zI7B5y8DYfFWI+thKeM3D?=
 =?us-ascii?q?m0HpJIfGBKEFOMHmnyd4WCRfgMbDieIsh7kjwLTbKhUZMu1QmytA/mzLpqNv?=
 =?us-ascii?q?TU+iwCtZLkz9V05vPclRcz9TxqFcid12CNT2dpnmIHXTM227p/oUNnxlee0q?=
 =?us-ascii?q?hym+ZYGsBL5/NVTgc6MobRz+h7C9D0RwLAcc6FSFi9Qtq7Hz4xUMw+w9sVbk?=
 =?us-ascii?q?ZjFNWtkArD0zCpA7ALjbyLAoI78qbG03j2PcZ9xG7M1LM9gFk+XstPKWqmi7?=
 =?us-ascii?q?Zl9wfPGo7EiFuZl6m0eqQGxiLN93mMzXCIvE5GVA58S6LFXWoQZhiekdOs2U?=
 =?us-ascii?q?LGS/eCBL0sNQ0JndGDLq9iadDzi1hCAvD5N4KNTXi2njKLGRuQxr6KJLHvcm?=
 =?us-ascii?q?EZ0TSVXFMIiCgP7H2GMk44HS7nrGXAWm89XWnzal/hpLEt4EiwSVU5mkTTMh?=
 =?us-ascii?q?xs?=
X-IPAS-Result: =?us-ascii?q?A2BQAAA1WtVd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsgUABMoRUj1ABAQEBAQEGgREliWaRQwkBAQEBAQEBAQE0A?=
 =?us-ascii?q?QIBAYRAAoInJDgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjFUEQCxgCA?=
 =?us-ascii?q?iYCAlcGDQgBAYJfP4JTJbAugTKFToM2gUiBDiiMFhh4gQeBOAyCXz6EL4Mmg?=
 =?us-ascii?q?l4Ell5GlwqCNYI3kxIGG4I+jCOLMy2qOCKBWCsIAhgIIQ+DKE8RFIdtAQiNN?=
 =?us-ascii?q?CMDgTUBAYsnKoIWAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 20 Nov 2019 15:28:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAKFSV1v032640;
        Wed, 20 Nov 2019 10:28:32 -0500
Subject: Re: [RFC PATCH 1/2] selinux: Don't call avc_compute_av() from RCU
 path walk
To:     Will Deacon <will@kernel.org>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        linuxfs <linux-fsdevel@vger.kernel.org>, rcu@vger.kernel.org
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-2-will@kernel.org>
 <5e51f9a5-ba76-a42d-fc2b-9255f8544859@tycho.nsa.gov>
 <20191120131229.GA21500@willie-the-truck>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d8dbd290-0ffa-271f-0268-5e9148e7ee9b@tycho.nsa.gov>
Date:   Wed, 20 Nov 2019 10:28:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120131229.GA21500@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/19 8:12 AM, Will Deacon wrote:
> Hi Stephen,
> 
> Thanks for the quick reply.
> 
> On Tue, Nov 19, 2019 at 01:59:40PM -0500, Stephen Smalley wrote:
>> On 11/19/19 1:40 PM, Will Deacon wrote:
>>> 'avc_compute_av()' can block, so we carefully exit the RCU read-side
>>> critical section before calling it in 'avc_has_perm_noaudit()'.
>>> Unfortunately, if we're calling from the VFS layer on the RCU path walk
>>> via 'selinux_inode_permission()' then we're still actually in an RCU
>>> read-side critical section and must not block.
>>
>> avc_compute_av() should never block AFAIK. The blocking concern was with
>> slow_avc_audit(), and even that appears dubious to me. That seems to be more
>> about misuse of d_find_alias in dump_common_audit_data() than anything.
> 
> Apologies, I lost track of GFP_ATOMIC when I reading the code and didn't
> think it was propagated down to all of the potential allocations and
> string functions. Having looked at it again, I can't see where it blocks.
> 
> Might be worth a comment in avc_compute_av(), because the temporary
> dropping of rcu_read_lock() looks really dodgy when we could be running
> on the RCU path walk path anyway.

I don't think that's a problem but I'll defer to the fsdevel and rcu 
folks.  The use of RCU within the SELinux AVC long predates the 
introduction of RCU path walk, and the rcu_read_lock()/unlock() pairs 
inside the AVC are not related in any way to RCU path walk.  Hopefully 
they don't break it.  The SELinux security server (i.e. 
security_compute_av() and the rest of security/selinux/ss/*) internally 
has its own locking for its data structures, primarily the policy 
rwlock.  There was also a patch long ago to convert use of that policy 
rwlock to RCU but it didn't seem justified at the time.  We are 
interested in revisiting that however.  That would introduce its own set 
of rcu_read_lock/unlock pairs inside of security_compute_av() as well.

