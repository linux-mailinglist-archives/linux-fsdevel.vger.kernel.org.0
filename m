Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB915F7A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgBNUXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 15:23:37 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:25819 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgBNUXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:23:37 -0500
X-EEMSG-check-017: 56145307|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56145307"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 20:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581711815; x=1613247815;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Yh8yVLzfgcJrNxKWl5z8u9g/3WjkV3f+RBoxNQYxV4E=;
  b=SEjRFt+jPcV9d7xQ62emkRKBYfsit3hOVekv1/DwwiF5oakkpP17NzWX
   VVXQpk2mV0jH9UN9n38HRgU/XvFPkyCelfxznnJHvH9Iwuogof2WjGaPU
   4KYZ/+b4DTTO1L09qVa0fU6HAKl9nO1K/VtW1OyTedB+KO2N50r/AHjnI
   Q8AiHI1dXqh3azBLfk1EbPVaavaOrozkSReb9pYccrzTv13eIVvEWZpKH
   Q8WLrY3+g1IRB8K/1kI6Ph3sKakQuzqWKqCfKDnVUoYCPAT8t4JeR74Qn
   cofMpTvxl6hbjRZBbwgi1NxDfGjvgLj73zE2GLtqrxrdsFeVbZ4dh48t7
   A==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="39155698"
IronPort-PHdr: =?us-ascii?q?9a23=3AgzRpzBR99aF4BifuhODwqvMPatpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YB2Ot8tkgFKBZ4jH8fUM07OQ7/m8HzNYqs/a7zgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4lvJro+xh?=
 =?us-ascii?q?fUrHZFefldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U7NVCSktPn?=
 =?us-ascii?q?426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07Qz?=
 =?us-ascii?q?Wi76NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWW?=
 =?us-ascii?q?pBRdtaWyhYDo+hc4cDE+8NMOBWoInno1sFsAWwCw+iCujyzjNEn3/70Kk/3+?=
 =?us-ascii?q?knDArI3hEvH8gWvXrJrNv7KqkSX+O7wqbGwjrMbe9Z1zjm5YjUcR0su+2AUa?=
 =?us-ascii?q?5+fMfTz0QkCgPLjk+XqYzgJz6by/gNvHaD7+pgS+2vjXMspRx0oje1wscsjp?=
 =?us-ascii?q?fGh4IIwV3D7iV23Z01KMakSE97fdGkEJxQuzucN4ttWMwuWW5ouCEkyrAfv5?=
 =?us-ascii?q?OwYSsEyIw/yhLCZPGKfJKE7xL+WOqLPzt1i2xpdKiiixu07EOu0PfzVtOu31?=
 =?us-ascii?q?ZPtidFl97MuW0T2BHL8ciHT+d9/l+m2TaSywDf8uFELl4wlarcM5Mh3qQ/lo?=
 =?us-ascii?q?ASsUTeBS/6gkT2jKmYdkUj4ein9fjobq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudPFFBA5NRC7w+HjCNhm2YMeXmWPAq?=
 =?us-ascii?q?CdMKzMq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhhV8dfKyp3Z4KaHCiBPRpOU?=
 =?us-ascii?q?WYbGHjgtcGFmcKsQ4+Q/LwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5i2gLOf2C?=
 =?us-ascii?q?e7H5tWZn1JC12XD3foeJuLW+0WZCKRPMBhiDoEWqalS4M70hGurgD6waJ9Lu?=
 =?us-ascii?q?XI4i0YqY7j1N9t6u3XlBEy8yF0DsuE32GWUW57gn4IRyU33KBjoU1x01KD0a?=
 =?us-ascii?q?9ljPxFEdxc+ehEUhk1NZHC1ex2EdPyVRzbftePVlmmRs+qATYrTtI+29UOeV?=
 =?us-ascii?q?pyG82+jhDf2CqnG7sVl72NBJwp/aPQxnbxJ91gxHnYyqkukV0mT9BRNW2pmK?=
 =?us-ascii?q?F/7RLfB43XnEWDkaala6Ac0DTK9GeZwmqEpFtYXxJoUaXZQXAfYVPbrdD45k?=
 =?us-ascii?q?PEUr+vBq0rMghfxs6YLKtFdNnpgE5YRPfsJtveeXi9m2SuChaSwLODco7qd3?=
 =?us-ascii?q?8a3CXHB0gOixoT8mqeNQgiGiehpHrTDD9wFVLqeE7s7+Z+p22hTkMuzAGFcV?=
 =?us-ascii?q?dh17yr9R4Rn/CcTOkT3r0csic7tzp0BEq9387RC9eYuQphfb9cYdQm7VZGy2?=
 =?us-ascii?q?3ZsQ19PoK6I6Bmh14edRl3vkz02xVwEIVAntImrG4pzABqM6KXzEtBdy+E3Z?=
 =?us-ascii?q?D3IrDXMnP9/A2ra6PNwlHRysuW+qMW5PQ9rFXjuxupGVQ4/3p71NlV1mOW5o?=
 =?us-ascii?q?/WAwoKTZLxTkE3+gB8p7HcYSkw/IzU1XprMam7tj/NxcglC/ciyhalZ91fKr?=
 =?us-ascii?q?+LFBfuE80GAMijMOgqm1+qbh0aJ+BS9KE0P8K7ePucwqGmJ+lgnDWhjWRI5I?=
 =?us-ascii?q?ByzFiA+DZ7Su7Nx5wF2e2X3hObVzfgi1esqsL3lp5KZTEcAGqy0ifkBIlWZq?=
 =?us-ascii?q?19eYYEF32iLNGwxtV71NbRXCt0/ViiCldO88itcAGZblv70EUE2U0RqnujsS?=
 =?us-ascii?q?S/yDNwnnciqa/JjwLUxOG3TwYKIm5GQiFZiF7oJYWlx4QBUFOAcxkilBzj41?=
 =?us-ascii?q?3zgadcuvIsfCHoXU5Ucn2ufClZWayqu+/HOpMe5Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ANAwAXAUde/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWCDRKEPokDhlwBAQEDBoESJYlwkUoJAQEBAQEBAQEBNwQBAYRAAoIlOBMCE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAQFshUOCOykBgwIBBSMPAQVBEAsOCgICJgICVwYNCAEBg?=
 =?us-ascii?q?mM/glclriiBMokfgT6BDiqMPnmBB4E4DAOCXT6HW4JeBI1ggj6Hb5dtgkSCT?=
 =?us-ascii?q?5N8BhybGKwnIoFYKwgCGAghD4MoTxgNjikXjkEjA5EIAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2020 20:23:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EKMXfe033109;
        Fri, 14 Feb 2020 15:22:33 -0500
Subject: Re: [PATCH 2/3] Teach SELinux about anonymous inodes
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, paul@paul-moore.com,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
References: <20200211225547.235083-1-dancol@google.com>
 <20200214032635.75434-1-dancol@google.com>
 <20200214032635.75434-3-dancol@google.com>
 <9ca03838-8686-0007-0971-ee63bf5031da@tycho.nsa.gov>
 <CAKOZuev-=7Lgu35E3tzpHQn0m_KAvvrqi+ZJr1dpqRjHERRSqg@mail.gmail.com>
 <23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov>
 <97603935-9f6b-ccf4-4229-87f26380c3db@tycho.nsa.gov>
Message-ID: <6d8f2e69-85e0-5313-337f-53144cf08218@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 15:24:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <97603935-9f6b-ccf4-4229-87f26380c3db@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/20 1:08 PM, Stephen Smalley wrote:
> On 2/14/20 1:02 PM, Stephen Smalley wrote:
>> It shouldn't fire for non-anon inodes because on a (non-anon) file 
>> creation, security_transition_sid() is passed the parent directory SID 
>> as the second argument and we only assign task SIDs to /proc/pid 
>> directories, which don't support (userspace) file creation anyway.
>>
>> However, in the absence of a matching type_transition rule, we'll end 
>> up defaulting to the task SID on the anon inode, and without a 
>> separate class we won't be able to distinguish it from a /proc/pid 
>> inode.  So that might justify a separate anoninode or similar class.
>>
>> This however reminded me that for the context_inode case, we not only 
>> want to inherit the SID but also the sclass from the context_inode. 
>> That is so that anon inodes created via device node ioctls inherit the 
>> same SID/class pair as the device node and a single allowx rule can 
>> govern all ioctl commands on that device.
> 
> At least that's the way our patch worked with the /dev/kvm example. 
> However, if we are introducing a separate anoninode class for the 
> type_transition case, maybe we should apply that to all anon inodes 
> regardless of how they are labeled (based on context_inode or 
> transition) and then we'd need to write two allowx rules, one for ioctls 
> on the original device node and one for those on anon inodes created 
> from it.  Not sure how Android wants to handle that as the original 
> developer and primary user of SELinux ioctl whitelisting.

I would tentatively argue for inheriting both sclass and SID from the 
context_inode for the sake of sane policy writing.  In the userfaultfd 
case, that will still end up using the new SECCLASS_ANONINODE or 
whatever since the sclass will be initially set to that value for the 
transition SID case and then inherited on fork.  But for /dev/kvm, it 
would be the class from the /dev/kvm inode, i.e. SECCLASS_CHR_FILE.

