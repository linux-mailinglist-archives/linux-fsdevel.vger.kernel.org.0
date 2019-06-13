Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4892144B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfFMSqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 14:46:44 -0400
Received: from uhil19pa14.eemsg.mail.mil ([214.24.21.87]:15913 "EHLO
        UHIL19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfFMSql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:46:41 -0400
X-EEMSG-check-017: 61114394|UHIL19PA14_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jun 2019 18:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560451593; x=1591987593;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=W8eTWLv9tHywO5BpKJxyj7MNrrIdkJL3Y6n3rMjH5ts=;
  b=T+8qluC/UFgE2QSLbuHUAFuQJ7xgGfSjehXDYT8+nEOeDbeRUTivduiP
   6cHCJJmse1lPZm3pyxCfF5j/siBah2kgTX/MSwwIIyMAsPflqmiPer/wf
   2Sl9QLP47nS2nUP07MC4nNqXgdJIsl2IvwDfXo2YZZJPAxG6dBim3wTbZ
   SL6HpGZ3K4dMnVaKxWzORy/a6HzK+TRSDRnbTcHLKs1t892G5HYfCidJZ
   NB9SxFSlE6FYpApta9s/Mam5NTVtAr++S+fzoRcxMjaWQ9NED4XAAHe6n
   3ZglMWg+tQpbIMpCbhaeVhjGEJaZRELmqnMqzyko5/J+6Vh4b5PPWnBPO
   w==;
X-IronPort-AV: E=Sophos;i="5.63,369,1557187200"; 
   d="scan'208";a="24726270"
IronPort-PHdr: =?us-ascii?q?9a23=3A8c5gXRd6GHq0oOq8ssDlLq5plGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc25ZhON2/xhgRfzUJnB7Loc0qyK6vmmADFRqs/b7jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajItmJ6o+1x?=
 =?us-ascii?q?fFvHpFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1BO7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0gw9EdwQvnTar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJrUTCHjP5mEXxjKOMcEUr5vOo5Pj9brXjp5+cM5d4igD4MqswhsyyGfk0Pw?=
 =?us-ascii?q?cBUmSB+emwyafv8VP2TblUlPE6j7HVsJXAKsQaoq65DRVV0oEm6xunFDepzc?=
 =?us-ascii?q?8YkGIbLFNFZB2Hj4/pN0vIIPDjF/izmVuskDB1x/zeJL3uHo3NLmTfkLfmZb?=
 =?us-ascii?q?ty9k5cyA09zN9B45JUDqoBLenpWkDvqdPYDgU2MxCuz+n7D9V905sUWXiTDa?=
 =?us-ascii?q?+BLKPSrViI6/ozLOaWf48apjb8JuM+5/HyjX82g0Idfaet3ZQJcnC0B+hpLF?=
 =?us-ascii?q?+DbXXwhdcBFH8AvhAiQ+zylF2CTTlTam62X6Ih+jE7D5mrDYTdSYC3hryOwi?=
 =?us-ascii?q?O7EodRZmBcBVCGCW3oeJmcW/cQdCKSJddskiIFVbi7TI8szhCvuxH8y7pmMO?=
 =?us-ascii?q?rY4CkYtZPl1Nho6OzfjxYy9SZ7D8iHzmGNTHl+nnkUSD8uwKB/vUt9x0+H0a?=
 =?us-ascii?q?h5hfxYCNNS6+pUUgchLpHR1PJ6C9/sVQLbZNuJS0ipQs+gAT4vStI92dgOY1?=
 =?us-ascii?q?xyG9+6lBDMwzKqA6MJl7yMHJE09qPc337sJ8dy0nrGz7cugEU7QstVNG2mmq?=
 =?us-ascii?q?5++xHWB47OjkqZiqKqeroH0S7T+2eM03COsFtbUAFuS6XFW24QZk/ModT+/E?=
 =?us-ascii?q?PCQKekCa47PQtZ1c6CNqxKZ8XtjVVHQvfjJdvfb3u/m2erGBmH2K2MY5Tue2?=
 =?us-ascii?q?gGwiXdB1YLkxoJ8XaFKwc+HCGhrHzaDDB0ElLveUzs+/FkqHynVk800x2Kb0?=
 =?us-ascii?q?p52rqx+x4Vg+GcSvwK0rIHpighsTN0E0i539/NFdqAqBRufL9GbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpC6KKBinFEeeRxtv0zyzxV3FplAkc8yoXMy1gVyNKaY3UhZdzyCwJ?=
 =?us-ascii?q?DwPqTbKmz1/BCoca7ZxEvS38qR+qcKu7wErADPtR+oGgIC9Gpq191Omy+Q5p?=
 =?us-ascii?q?LVAQ4WSrrrX0o3/gQ8rLbfNHoT/YTRgEZwPLG0vzmK4NcgAO8o2170ZNtEGL?=
 =?us-ascii?q?+VHw/1VcsBDo6hL/J8yAvhVQ4NIO0HrP18BMihbfbTnff2bes=3D?=
X-IPAS-Result: =?us-ascii?q?A2DLDgDKmAJd/wHyM5BmHgEGBwaBZYFnKoE7ATIohBaTQ?=
 =?us-ascii?q?gECAQEBBoE1iVGPJIFnCQEBAQEBAQEBATQBAgEBhEACgkkjOBMBAwEBAQQBA?=
 =?us-ascii?q?QEBAwEBbCiCOikBgmYBAQEBAgEjFToFAhALDgoCAiYCAlcGDQYCAQGCXz+Bd?=
 =?us-ascii?q?wUPqzWBMYhrgUaBDCiLXRd4gQeBOIJrPoN+LoMiglgElB6VLgmCEoIbkSsGG?=
 =?us-ascii?q?4ImiwqJfKV7IYFYKwgCGAghD4MnghsXjjwjAzCBBgEBjWqCQwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Jun 2019 18:46:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5DIkUSV011773;
        Thu, 13 Jun 2019 14:46:31 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: What do LSMs *actually* need for checks on notifications?
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@kernel.org>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <05ddc1e6-78ba-b60e-73b1-ffe86de2f2f8@tycho.nsa.gov>
 <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <31009.1560262869@warthog.procyon.org.uk>
 <25045.1560339786@warthog.procyon.org.uk>
Message-ID: <deef1cbd-993e-78e4-396f-0f80b4da4668@tycho.nsa.gov>
Date:   Thu, 13 Jun 2019 14:46:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <25045.1560339786@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/19 7:43 AM, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>>>    (6) The security attributes of all the objects between the object in (5)
>>>        and the object in (4), assuming we work from (5) towards (4) if the
>>>        two aren't coincident (WATCH_INFO_RECURSIVE).
>>
>> Does this apply to anything other than mount notifications?
> 
> Not at the moment.  I'm considering making it such that you can make a watch
> on a keyring get automatically propagated to keys that get added to the
> keyring (and removed upon unlink) - the idea being that there is no 'single
> parent path' concept for a keyring as there is for a directory.
> 
> I'm also pondering the idea of making it possible to have superblock watches
> automatically propagated to superblocks created by automount points on the
> watched superblock.

So at the point where you can set a watch on one object O1 with label X, 
and receive notifications triggered upon operations on another object O2 
with label Y, we have to consider whether the relationship between X and 
Y is controlled in any way (possibly transitively through a series of 
checks performed earlier) and whether we can reasonably infer that the 
authorization to watch X implies the ability to be notified of 
operations on Y.  Not a problem for the mount notifications AFAICS 
because there is only truly one object - the mount namespace itself, and 
it is always our own.

> 
>> And for mount notifications, isn't the notification actually for a change to
>> the mount namespace, not a change to any file?
> 
> Yes.
> 
>> Hence, the real "object" for events that trigger mount notifications is the
>> mount namespace, right?
> 
> Um... arguably.  Would that mean that that would need a label from somewhere?

That takes us into the whole question of whether namespaces should be 
labeled (presumably from their creator), and the association between 
processes and their namespaces should be controlled.  I think when we 
originally looked at them, it wasn't much of a concern since the only 
means of creating a new namespace and associating with it was via 
clone() and then later also via unshare().  /proc/pid/ns and setns() 
changed that picture, but still requires ptrace read mode access, which 
at least provides some control over entering namespaces created by 
others. I suspect that ultimately we want namespaces to be labeled and 
controlled but that isn't your problem to solve here.

For your purposes, a process is setting a watch on its own namespace, 
and it already inherently can observe changes to that namespace without 
needing watches/notifications, and it can modify that namespace iff 
privileged wrt to the namespace.  One might argue that no check is 
required at all for setting the watch, and at most, it would be a check 
between the process and its own label to match the checking when 
accessing /proc/self/mounts. That presumes that no additional 
information is conveyed via the notification that isn't already 
available from /proc/self/mounts, particularly any information specific 
to the process that triggered the notification.  Does that make sense?

> 
>> The watched path is just a way of identifying a subtree of the mount
>> namespace for notifications - it isn't the real object being watched.
> 
> I like that argument.
> 
> Thanks,
> David
> 
