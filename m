Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E81195858
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 14:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgC0NsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 09:48:22 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:52157 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:48:22 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 09:48:21 EDT
X-EEMSG-check-017: 93004792|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="93004792"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2020 13:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585316435; x=1616852435;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aclVecdxZ7tQS+v8MD4ZG7hm+P1deCZxL8udM9zRKeU=;
  b=MypQwT1dXy8417Jcg8xituSqrVreuAFTeeSQht102Uf0z2h4mnkjSPhi
   Op1Z9ggvZHachdVfHZp+C+eJKuxGWojI3H7foqRsxRJu4SmiRj+tdNzWI
   S28hmTLUZlE7JDwGVzmlh3xHflw3ym91b/Jg934qZ6akrsIeLDdmNR6sZ
   k27Il7YJ0fdcgCZ6vqxAX3who5F+YxFGlSY3EbE6NAr9it+mnY4ntoiru
   cTqyPNYwdXg5MzuxumW7kTR4aPtbKfW+aT/XwOOWWKAZsabHaPtcTzpGL
   /oPMl5tjF50sjsiSQ9a6wZJkiLryt0pc+woE1hq71GqALMG4U1TRwmLsc
   Q==;
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="41132479"
IronPort-PHdr: =?us-ascii?q?9a23=3Ay0nKExM9NvOs4ut7KLYl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/v+r8bcNUDSrc9gkEXOFd2Cra4d16yP7vGrBDVIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/MusQWhYZuJaY8xg?=
 =?us-ascii?q?bUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7fHi72hEr2jKiWel8i+ue08OTofq/qppqdN49wkg3+M6IuldKjAekgLw?=
 =?us-ascii?q?QDUGeW9f682bH+50H1XrpHguMsnqXEqJzaIN4Upq+9Aw9byIYj7BO/Ai+90N?=
 =?us-ascii?q?sFhnkKN05FeRKbgIjpPFHCOvb4DeyljFi2nzdrwO7GMqX7AprRNnjDjKvhfb?=
 =?us-ascii?q?Fl5kFB0gUzy8xQ55VQCrwaL/LzXUjxtNPcDhAnKQC73+HnCNBl3IMERW2PGr?=
 =?us-ascii?q?OZML/VsVKQ+uIvIuyMZIoIuDbnMfgq/f7vgGQ2mV8aeqmp0p8XZ26iEvt6JE?=
 =?us-ascii?q?WZZGLmgs0dHmcSogo+UOvqhUWZUTFNY3ayXqQ85iw0CY+9E4fDSZ6igKab0C?=
 =?us-ascii?q?e4AJJWfGZGBU6IEXvycIWEQfgMYjqIIsB9ijwESaShS4g52BGqtQ/6zadnL+?=
 =?us-ascii?q?XN9i0Dq53syMV15/fSlREu9T14FsGd02aQQGFpmmMHWSQ73L5woUNj0FePy6?=
 =?us-ascii?q?t4jOJCFdxV+fxJVh02NZnGz+x1E9ryQB7Ofs+VSFa6RdWrGTUxTtM3w98TbE?=
 =?us-ascii?q?dxAtuijgve0CW0Hb8aibiLCYcq8qLTwXfxPdxxy3XY26k7iVkpXM9POXehhq?=
 =?us-ascii?q?5l+AjZH5TJnFmBl6a2aaQc2zbA9GOCzWqIoUFZXxd8UabbUnAFYEvZs9D561?=
 =?us-ascii?q?jcT7+hF7snKBFNyc2cJatQbN3mk1FGSO3kONTEbGK7g32wCgqQxrOQcIrqfH?=
 =?us-ascii?q?0Q3CbDCEgBiA0T43mGOhYkBiu7oGLREiZuFVTxbEPo6+V+r2m7TkAsxQGQc0?=
 =?us-ascii?q?Jhz6a1+gIShfGEVfMT36gEuCA6pjR1Alm92dPWC8SaqwplfaVcZ8494Vhd2W?=
 =?us-ascii?q?LerQx9MYasL71hhlQGaQR4o1vu1wlrCoVHicUqtGklzBd2Ka+DyFNObS6Y3Z?=
 =?us-ascii?q?TpNr3SLWny+wqvZLDM1l7C19aW/78F6O4kpFX7oAGpCk0i/m1h09lT0HuR/Z?=
 =?us-ascii?q?rKDA0VUZL+VkY46QJ2qK3dYik4/4nUz2FjMbGosj/e3NIkHO8lyhGjf9hBK6?=
 =?us-ascii?q?OEFADyE8wHCMi0MuMngFepbhUDPOBd8K47IdmqeOeB2K6uJOxghi6pjXxb4I?=
 =?us-ascii?q?Bh1UKB7yh8SuvP35Yf2fGY3xCHWiz6jFi7t8D4h4FEaSsVHmqlxii3TLJWM4?=
 =?us-ascii?q?F7e4cGDS+FJMm+3d5/gJjgEypU/VioAFcu18iudh6fKVf62FsUnVgWpHm6gz?=
 =?us-ascii?q?Gx3hR7lDYmqqfZ1yvLh6z5eR4GPHNbbHdtgE2qIoWuid0eGk+yYExhkBqj+F?=
 =?us-ascii?q?a/3KVQub5+M3iWREBEYiz7B39tX7H2tbeYZcNLrpQyvmEfVOW6fEDfRKXxrg?=
 =?us-ascii?q?UX1wv9EGZEgjM2bTenvtP+hRM+wGacKmtj6XnUY8d9wT/B69HGA/1cxDwLQG?=
 =?us-ascii?q?9/kzaTTluiOvG38tiO0ZTOqOazUySmTJIXOTfq14Sopia95HMsBRy5guD1nc?=
 =?us-ascii?q?foVxU5lWfj3sRufT3BsRK5Z47szan8OuViOgFuAlzU5M19FYVz1IA3gdVY3X?=
 =?us-ascii?q?8Zi46V8nsLi27bPtJc1qbzKnEKQHpDwdvS+hLkw2VlJ3eExsT+THrO7NFmYo?=
 =?us-ascii?q?yBfm4O2i87p/tPAaOQ4a0MyTB5uXKkvAnRZr57hT5bxvwwvi1Jy9oVsRYgm3?=
 =?us-ascii?q?3OSosZGlNVaGm1zEWF?=
X-IPAS-Result: =?us-ascii?q?A2AKAQAhAX5e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8LIFAATIqhBqOfFIBAQaBCggliXuQdgNUCgEBAQEBAQEBATQBAgQBA?=
 =?us-ascii?q?YREAoIxJDcGDgIQAQEBBQEBAQEBBQMBAWyFYoI7KQGDDAEFIxVRCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjP4JYJaxLgTKFS4NtgT6BDioBjC4aeYEHgTgMA4JePodgg?=
 =?us-ascii?q?l4ElxFxmFuCRoJWlDAGHZtpjxSeCiM3gSErCAIYCCEPgydQGA2cLFUlAzCBB?=
 =?us-ascii?q?gEBjX4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Mar 2020 13:40:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02RDevOf212468;
        Fri, 27 Mar 2020 09:40:57 -0400
Subject: Re: [PATCH v4 2/3] Teach SELinux about anonymous inodes
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, lokeshgidra@google.com, jmorris@namei.org
References: <20200326181456.132742-1-dancol@google.com>
 <20200326200634.222009-1-dancol@google.com>
 <20200326200634.222009-3-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <118df484-7971-54e7-2a62-a07afc3c627d@tycho.nsa.gov>
Date:   Fri, 27 Mar 2020 09:41:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326200634.222009-3-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/26/20 4:06 PM, Daniel Colascione wrote:
> This change uses the anon_inodes and LSM infrastructure introduced in
> the previous patch to give SELinux the ability to control
> anonymous-inode files that are created using the new _secure()
> anon_inodes functions.
> 
> A SELinux policy author detects and controls these anonymous inodes by
> adding a name-based type_transition rule that assigns a new security
> type to anonymous-inode files created in some domain. The name used
> for the name-based transition is the name associated with the
> anonymous inode for file listings --- e.g., "[userfaultfd]" or
> "[perf_event]".
> 
> Example:
> 
> type uffd_t;
> type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> allow sysadm_t uffd_t:anon_inode { create };
> 
> (The next patch in this series is necessary for making userfaultfd
> support this new interface.  The example above is just
> for exposition.)
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

