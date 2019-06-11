Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71CC3D195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbfFKP7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 11:59:14 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:2984 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388492AbfFKP7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:59:14 -0400
X-EEMSG-check-017: 684741867|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,362,1557187200"; 
   d="scan'208";a="684741867"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Jun 2019 15:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560268676; x=1591804676;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZoRzzwnUupnCbxMXe+I2jJc705um28RURpHG4yHU9FI=;
  b=MHVS6Jn4gzTO7Igiz4EthK3bZyjvmzsyOlifP2p0pm7TTcmciKGbz3LK
   8Baby3kt83WL97T0PkcfGf9PLCiQq8c4VV88YBmwdq8I9Pz1Ydow0oroH
   tqz60g/AMCrfofWYXG3eA0To++wYpiqCEvQ943xTS025und9ro3eIuryp
   WdrGdpXGS+gTcOvw/ArTb9g3iEtf6VmOA1YFQGjo4+ZpiPvi290KE4D4J
   IBaqfdS7As3I0c/Z/UzokkxHJ/A3jmnWWunuw5BcDhgVtURgHlc6NeHgV
   23ySv+xH8e1rp8a2+kv5HSCMLI5Z2GzwYhY42vw4LSdwg4CNIAn34Rsx8
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,362,1557187200"; 
   d="scan'208";a="24617617"
IronPort-PHdr: =?us-ascii?q?9a23=3ASlbgChyiyE8UgPTXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ukSLfad9pjvdHbS+e9qxAeQG9mCsrQd1red7P+ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmSexbalvIBi2rQjducsbjIl/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwp18DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbN54gzaIwlp?=
 =?us-ascii?q?oUq0jDGDP5mF7qg6OMc0Uk++yo5/zmYrXguJCcK5d5hhzxP6khgMCyAfk0Ph?=
 =?us-ascii?q?IQU2WU5+iwzqDv8VX8QLpQj/02lqfZsIrdJcQevqO5GBJa0p045hajDzapzN?=
 =?us-ascii?q?QYnX4dIFJDYxKIlZLlO17JIPDmFfu/mUijkC93x/DaOb3sGojCLnjEkLbvY7?=
 =?us-ascii?q?l970pcyBEowNBF+Z1bF7EBL+jvWkPrqNPYCRo5ORSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?CFKqzSqkGH5+I0LumXeIAVuCzyK+Ur5/7qk3A5g0YRcrWz0pcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQezulV2CTTlTam2xX60i/DE7DpypDYPZSoCqmryB0z?=
 =?us-ascii?q?+xHodKaWBeFlCMDXDoep2aW/cNciKSJdRskz0aWrinSo8hywuitAv7y7phM+?=
 =?us-ascii?q?rV9TcUtZX51Nh6/eHTiBIy/yRuD8uBy2GNU310nmQQSj8y3aB/p1F9y1ia3a?=
 =?us-ascii?q?hlmPxXDsde5+1GUggkL57Q1e96BM7oWgLHYNiJTEyqQtK8ATE+Vtgx2cMBY1?=
 =?us-ascii?q?5hG9W+iRDOxy6qA74Tl7yWC50467nc0GbtKMZg0XbG1bUhjlk/TstKMm2pm7?=
 =?us-ascii?q?N/9wzNCIPSjUWZmLildb4G0C7O6miD12yOs19cUAJqVqXFR38fbFPMrdvl/k?=
 =?us-ascii?q?PCU6OuCbM/PwtFyM6CLLZKa9LwgVVIX/fsJcrRY3yvlGe0HhuI2LyMY5Twe2?=
 =?us-ascii?q?kH3yXSFlIEkwYN8naCLwQ+AT2ho23GBjx0CV3ve1/s8fV5qH6jSk80zgeKb1?=
 =?us-ascii?q?Bu1ras+R4am+acS/UN0bIAoyohtTp0E0in397MCNqPuRBhfKNCbtM5+ltH0n?=
 =?us-ascii?q?jZtwMudqCneoxrmF8SOyRwoE7q0w4/XolAltcnqHcx5BB/JaKRzBVKcDbOmd?=
 =?us-ascii?q?jbM6baOyHJ9xCmdqDS10uWhN2f4aoewO8zq1z+sgWkDA8p+jNs1NwDlzO14J?=
 =?us-ascii?q?nbRC4PTZX0U1ws9Bky87XHfi4V5I7O03Bod66uvWmR9cguAb4e1hu4f9pZeJ?=
 =?us-ascii?q?iBHQv2HtxSU9OiM8Q2ilOpaVQCJ+kU+6kqaZD1P8Ca0bKmab4z1Amtin5Ktc?=
 =?us-ascii?q?UkjxOB?=
X-IPAS-Result: =?us-ascii?q?A2BDBwBWzv9c/wHyM5BmHAEBAQQBAQcEAQGBZYFnKoE8M?=
 =?us-ascii?q?oQ9kz8BAQEBAQEGgQgtiVGRCwkBAQEBAQEBAQE0AQIBAYRAAoJ+IzgTAQMBA?=
 =?us-ascii?q?QEEAQEBAQMBAWwogjopAYJmAQEBAQIBIwQRPwIFCwsOCgICJgICVwYBDAgBA?=
 =?us-ascii?q?YJTDD+BdwUPqVZ+M4VHgyqBRoEMKItdF3iBB4ERJ4JrPoQugyCCWASLSohEh?=
 =?us-ascii?q?0mNWgmCEoIbkSQGG4IliwSJeY0WmE0hgVgrCAIYCCEPgyiCGheOPCMDgTYBA?=
 =?us-ascii?q?Y9cAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Jun 2019 15:57:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5BFvs7B007485;
        Tue, 11 Jun 2019 11:57:55 -0400
Subject: Re: What do LSMs *actually* need for checks on notifications?
To:     David Howells <dhowells@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <31009.1560262869@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <05ddc1e6-78ba-b60e-73b1-ffe86de2f2f8@tycho.nsa.gov>
Date:   Tue, 11 Jun 2019 11:57:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <31009.1560262869@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/11/19 10:21 AM, David Howells wrote:
> To see if we can try and make progress on this, can we try and come at this
> from another angle: what do LSMs *actually* need to do this?  And I grant that
> each LSM might require different things.

I think part of the problem here is that the discussion is too abstract 
and not dealing with the specifics of the notifications in question. 
Those details matter.

> 
> -~-
> 
> [A] There are a bunch of things available, some of which may be coincident,
> depending on the context:
> 
>   (1) The creds of the process that created a watch_queue (ie. opened
>       /dev/watch_queue).

These will be used when checking permissions to open /dev/watch_queue.

>   (2) The creds of the process that set a watch (ie. called watch_sb,
>       KEYCTL_NOTIFY, ...);

These will be used when checking permissions to set a watch.

>   (3) The creds of the process that tripped the event (which might be the
>       system).

These will be used when checking permission to perform whatever 
operation tripped the event (if the event is triggered by a userspace 
operation).

>   (4) The security attributes of the object on which the watch was set (uid,
>       gid, mode, labels).

These will be used when checking permissions to set the watch.

>   (5) The security attributes of the object on which the event was tripped.

These will be used when checking permission to perform whatever 
operation tripped the event.

>   (6) The security attributes of all the objects between the object in (5) and
>       the object in (4), assuming we work from (5) towards (4) if the two
>       aren't coincident (WATCH_INFO_RECURSIVE).

Does this apply to anything other than mount notifications?  And for 
mount notifications, isn't the notification actually for a change to the 
mount namespace, not a change to any file?  Hence, the real "object" for 
events that trigger mount notifications is the mount namespace, right? 
The watched path is just a way of identifying a subtree of the mount 
namespace for notifications - it isn't the real object being watched.

> At the moment, when post_one_notification() wants to write a notification into
> a queue, it calls security_post_notification() to ask if it should be allowed
> to do so.  This is passed (1) and (3) above plus the notification record.

Not convinced we need this.

> [B] There are a number of places I can usefully potentially add hooks:
> 
>   (a) The point at which a watch queue is created (ie. /dev/watch_queue is
>       opened).

Already covered by existing hooks on opening files.

>   (b) The point at which a watch is set (ie. watch_sb).

Yes, this requires a hook and corresponding check.

>   (c) The point at which a notification is generated (ie. an automount point is
>       tripped).

Preferably covered by existing hooks on object accesses that would 
generate notifications.

>   (d) The point at which a notification is delivered (ie. we write the message
>       into the queue).

Preferably not needed.

>   (e) All the points at which we walk over an object in a chain from (c) to
>       find the watch on which we can effect (d) (eg. we walk rootwards from a
>       mountpoint to find watches on a branch in the mount topology).

Not necessary if the real object of mount notifications is the mount 
namespace and if we do not support recursive notifications on e.g. 
directories or some other object where the two can truly diverge.

> [C] Problems that need to be resolved:
> 
>   (x) Do I need to put a security pointer in struct watch for the active LSM to
>       fill in?  If so, I presume this would need passing to
>       security_post_notification().

I don't see why or where it would get used.

>   (y) What checks should be done on object destruction after final put and what
>       contexts need to be supplied?

IMHO, no.

> 
>       This one is made all the harder because the creds that are in force when
>       close(), exit(), exec(), dup2(), etc. close a file descriptor might need
>       to be propagated to deferred-fput, which must in turn propagate them to
>       af_unix-cleanup, and thence back to deferred-fput and thence to implicit
>       unmount (dissolve_on_fput()[*]).
> 
>       [*] Though it should be noted that if this happens, the subtree cannot be
>       	 attached to the root of a namespace.
> 
>       Further, if several processes are sharing a file object, it's not
>       predictable as to which process the final notification will come from.
> 
>   (z) Do intermediate objects, say in a mount topology notification, actually
>       need to be checked against the watcher's creds?  For a mount topology
>       notification, would this require calling inode_permission() for each
>       intervening directory?

I don't think so, because the real object is the mount namespace, not 
the individual directories.

> 
>       Doing that might be impractical as it would probably have to be done
>       outside of of the RCU read lock and the filesystem ->permission() hooks
>       might want to sleep (to touch disk or talk to a server).


