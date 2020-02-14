Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8615F233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392496AbgBNSHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:07:45 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:50945 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbgBNSHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:07:44 -0500
X-EEMSG-check-017: 56598909|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56598909"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 18:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581703661; x=1613239661;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZmEj9uPZdHOZAKRIp4AYJ5EUxrhvAKsghoYmsQJ8N7o=;
  b=Zhq0BFS0Y1HMVNQg/PSwdqMDhZeDtXpZLaF1qrpa4OgxAcuKbtnB+9BJ
   yKhPvd+rMtyUUhT7wj69hIXUpfwj2aksCSjXPTOA95gAI1WUGA6yaOzYU
   Ei/bbES0GI3zTkSw6wykstXuYHVKcnd3lY86/pdF0JQtSrhFNWFQey7CN
   ZsDqIUStWHApBTokmMUPh8vvUycpa7KgXAdiphUSv5WTGZIQWaOwCQ+Fr
   13yAJPXUV26ThO7VdDNUiyKyLbpg/COMyaCbAHg01220GfjTfR1gsH2o8
   tyNYweqLwzQFnr1k5lhIwaYhy73DBb8uklsyHmxSAkdJk/LaKb198nGXa
   A==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="39145515"
IronPort-PHdr: =?us-ascii?q?9a23=3A5Ab/UxN4X/ceccRAbyMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/jyrsbcNUDSrc9gkEXOFd2Cra4d16yJ6+u5AT1IyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Tu8UKjoduN7o9xx?=
 =?us-ascii?q?/UqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrvxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAtIAvmrarNv2OqkdX++6w6vUwjvMdP5WxTTw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7CHi/wlkX2i7SWeVs49eSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/8R1X+tNrEAR8+Nwy52OnnCNJ61oMRXWKAHL?=
 =?us-ascii?q?WVP7/VsV+N/ugvOfWDZJcJuDbhLPgo/+LujX48mV8YYKmpx4EXZ2q4H/l9LE?=
 =?us-ascii?q?WZZn3sgtgFEWgUpAYxUOvqiFiaWz5Je3myR7485i08CI++FofMWIStgL2H3C?=
 =?us-ascii?q?emEZxbfX5GCl+SHnfybYmEWOkDaDiUIsB/ljwIT7+hS5Uu1Ru2rg/116JnLv?=
 =?us-ascii?q?bI+i0frZ/j0Nl15+vOlRA97DB0FNqS3H2QT2Fun2MIWz830Ll6oUx611iDzK?=
 =?us-ascii?q?x4jOJDGNxN6PNGTB06OYTfz+NkEdDyXBzOftOTRFahWNWmDik7TsgtzN8Wf0?=
 =?us-ascii?q?Z9B9KigwjH3yqrBb8VirOKCIU68qLHwnf+Odh9xGjC1KQ6kVkmTdVANXe8iq?=
 =?us-ascii?q?586QfTHYjJnFudl6qwcqQcxiHN/n+ZzWWSpEFYTBJwUaLdUHAbZ0vWq8n550?=
 =?us-ascii?q?zbQ7+tF7snKA1BxtCGKqZRdN3pgktJRO35NNTdfW2xgWGwCgiMxr+Wa4rqYW?=
 =?us-ascii?q?od1j3HCEcYiwAT4WqGNQ8mCyeivWLeCSdjFUzgY0zy6+lysnC7QVEuzwGMcU?=
 =?us-ascii?q?Jh06C5+hkPhfyTU/kTxK4LuD89qzVoG1awx8zWC9uapwpmZ6hdYM0y4FFG1W?=
 =?us-ascii?q?LHrQB9Op2gL6Z/hl8RaQh3uFnu1xptBoVdksggtGkqwxZqKaKEzFNBcCuV3Y?=
 =?us-ascii?q?jqNb3KLmn/5wivZLTL2lHaydqW/6AP6PMiq1r9pg2mCk0i83B/2dlPz3Sc/o?=
 =?us-ascii?q?nKDBYVUZ/pVEY38Rt6qqrVYik64IPU2nlsPreuvjDe3NIpAfMvygy8cNdHLK?=
 =?us-ascii?q?OECAjyHtUeB8ipK+wlhUOpbhILPOBT6aE0JdmpeuCJ2K6sO+Zgkzamgnpd7I?=
 =?us-ascii?q?9h1UKM8jJ2SvTU0JYd3/GYwgyHWi/+jFi/vMD3l55EaCodHmq4zijkC4pRab?=
 =?us-ascii?q?NocYkXDmeuJp7/+tIrq5frWnNcvHWkA1od086ufxfaO1D02wZX0WwYpnuonS?=
 =?us-ascii?q?b+xDtxxWIHtK2aiRfSzvzieRxPAWtCQG1vnB+4OoSvp8wLV0ivKQ4ynV2q4l?=
 =?us-ascii?q?islPsTn7h2M2SGGRQARCPxNWw3F/Lt57c=3D?=
X-IPAS-Result: =?us-ascii?q?A2CMAwA84UZe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbSASh?=
 =?us-ascii?q?D6JA4ZZAQEEBoESJYlwkUoJAQEBAQEBAQEBNwQBAYRAAoIlOBMCEAEBAQUBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOykBgwIBBSMPAQVBEAsOCgICJgICVwYNCAEBgmM/glclr?=
 =?us-ascii?q?jiBMokdgT6BDiqMPnmBB4E4DAOCXT6HW4JeBI1ggj6Hb5dtgkSCT5N8BgIam?=
 =?us-ascii?q?xisJyKBWCsIAhgIIQ+DKE8YDY4pF45BIwORCAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2020 18:07:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EI6e3h233238;
        Fri, 14 Feb 2020 13:06:40 -0500
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
Message-ID: <97603935-9f6b-ccf4-4229-87f26380c3db@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 13:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/20 1:02 PM, Stephen Smalley wrote:
> It shouldn't fire for non-anon inodes because on a (non-anon) file 
> creation, security_transition_sid() is passed the parent directory SID 
> as the second argument and we only assign task SIDs to /proc/pid 
> directories, which don't support (userspace) file creation anyway.
> 
> However, in the absence of a matching type_transition rule, we'll end up 
> defaulting to the task SID on the anon inode, and without a separate 
> class we won't be able to distinguish it from a /proc/pid inode.  So 
> that might justify a separate anoninode or similar class.
> 
> This however reminded me that for the context_inode case, we not only 
> want to inherit the SID but also the sclass from the context_inode. That 
> is so that anon inodes created via device node ioctls inherit the same 
> SID/class pair as the device node and a single allowx rule can govern 
> all ioctl commands on that device.

At least that's the way our patch worked with the /dev/kvm example. 
However, if we are introducing a separate anoninode class for the 
type_transition case, maybe we should apply that to all anon inodes 
regardless of how they are labeled (based on context_inode or 
transition) and then we'd need to write two allowx rules, one for ioctls 
on the original device node and one for those on anon inodes created 
from it.  Not sure how Android wants to handle that as the original 
developer and primary user of SELinux ioctl whitelisting.
