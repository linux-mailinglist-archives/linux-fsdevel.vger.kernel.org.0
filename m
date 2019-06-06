Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03111375FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfFFOFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 10:05:37 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:60107 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFFOFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:05:36 -0400
X-EEMSG-check-017: 417620191|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jun 2019 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559829933; x=1591365933;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qjiB+TgtecEmugFOuRZniqAFFEeaEHAWbZJOl8IvGUA=;
  b=RDPmNXqYTUzZo2mbCk1RccK7roujLqM2Q3DgrPo51k+PCsOYjq33sqqs
   GmhOzsgPvXPIRrey5lEExgTYUWprjJLEt3cfsXuPmGDdpSdBLYYcANprW
   5qjLZprv//Mq+bZtHbxTgSTezY+4/BWa3/x+EiWYBCPhdjNj/1gidQNOQ
   xXWOeym6zVY9qTAJupkE5ws6c+yjl13IqzfsKflOo/vCxLMmFukLaPJxW
   GPSvDTbjCbZcf+f1A42jORRxwFQI+mf5iiAcnPXNKd16x9o8KrdBJdKHD
   OgbubL83QKaXWokLkZtkL3pPQ2dJXtChr/RmFWyha4FxKpOOAFfXpDmk3
   g==;
X-IronPort-AV: E=Sophos;i="5.63,559,1557187200"; 
   d="scan'208";a="28639817"
IronPort-PHdr: =?us-ascii?q?9a23=3AirVQ8xLpi502USgjRtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLP/5rarrMEGX3/hxlliBBdydt6sdzbOK7+u/ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oAreu8UZg4ZuNrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjfygF1o4nxxjBZPyDaYSI5QjjVOmXLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NulgH/Mrghmsy4AegiNA?=
 =?us-ascii?q?gBQ3Ob9vim2L3m/E35RK1GjvwwkqbHrJDXPdkXq6G2DgNP0osv9gyzAymp3d?=
 =?us-ascii?q?gGh3ULMUpJeBedgIjoP1HOLur4DfC6g1m0izdk2uvGM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG73ubnCNJz14wAXWKPBr?=
 =?us-ascii?q?SZPbjIsVCW++0vI/ODZJMPtDnhLPgl4ubkjWUlll8FYampwZwXZWimHvRnOU?=
 =?us-ascii?q?WZZmHhg9YfHmcMvwo+UvbmiFmDUT5VenazULgw5jYhCIKpF4vDW4OtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfnbYWLRfgMaCGSIsJ6ljwEVL6hS5Iu1BGgsw/61rxnIf?=
 =?us-ascii?q?fO9S0EtJLj09516/fUlREo+jx+F96d3H2VT2FogmMIQCc707xlrkxm1FiC0b?=
 =?us-ascii?q?N1g+dEGtxT/fxJTwk6NZrCwOxgEtz9RhjOcs2VR1ahR9WsGSsxQc4pw98Sf0?=
 =?us-ascii?q?Z9HM2vjhTC3yqsHr8UmKWHBIEv8q3HxHXxOcl9xGjc1KU7jFkpXNFPNWu4ia?=
 =?us-ascii?q?577QTTAJTJk0qBnaawaascxDLN9HuEzWeWpkFXShBwXrvDXX0EekvWrcr25k?=
 =?us-ascii?q?bYQL6gE7gnNBVOydKaIKtQdtLplUlGROvkONnGZ2KxmmGwBQuHx7+VYorqYH?=
 =?us-ascii?q?gS0zvDCEcalwAe5miGNQcgCSe7uW7eDyJhFUjpY0zy9elysnS7TlU7zwuSdU?=
 =?us-ascii?q?1uy6K1+gIJhfybU/4T2rMEuCE8qzR7BVqyxcrWC9ubqgp/c6VTf8k97E1E1W?=
 =?us-ascii?q?3HrQx9OIKvL6R4il4ZaQR3sFvk1w9rBYVYjcgqsHQqwRJ2KaKZ1lNBajyZ0Y?=
 =?us-ascii?q?nrNb3TLWn94BOvZrXI2lHRztmW4L0D6PcmpFX5ugGmCE4i/29g09lP3HuW/o?=
 =?us-ascii?q?/KAxYKUZLtTkY38AB3p7LEbSg9/YPU1HtsMaavsjLZxdIpC/Uqygy6c9dcLq?=
 =?us-ascii?q?yEDgnyHNMeB8S0L+wqgVepZAoePO9O7K40I9+md/ye1a6vPeZgmi+mjGte7I?=
 =?us-ascii?q?BmzE2D6zd8SvTJ35YZw/CUxw6HVzDhg1e8tsD4h5tJZS8dHmWh0yjoHo1Rab?=
 =?us-ascii?q?NofYYNF2iuJ9e7xtJkh57iQ3RY7kKsB0sa2M+1fhqfd1j93QxW1UQKrn2rgC?=
 =?us-ascii?q?i4wCJukzEvsKWf2DfDw/rtdBUZIG5HXmpigkn2IYiykd8aWFKkbw8zlBuq/U?=
 =?us-ascii?q?z63bRUpLxjL2nPRkdFZzD2IHt/Uqu0rbeCe9RA6I4ssSlOVeS8ZleaSqTjrB?=
 =?us-ascii?q?cAzyzjGG5el3gHcGSGs4v4k1Raj32QKHJo5C7VecZvyBPb//TGSPJR1yZATy?=
 =?us-ascii?q?5932r5HF+5auK18M2UmpGLieW3U2asR9UHaiXw5Z+Rvyu8o2txCFuwmO7lyY?=
 =?us-ascii?q?6vKhQzzSKuj4oibi7PthupJ9Cwhqk=3D?=
X-IPAS-Result: =?us-ascii?q?A2DqBADXHPlc/wHyM5BlHQEBBQEHBQGBZYFnKmpRATIoh?=
 =?us-ascii?q?BSTPQEBAQEBAQaBNYlRkQkJAQEBAQEBAQEBKwkBAgEBhEACgmMjOBMBAwEBA?=
 =?us-ascii?q?QQBAQEBAwEBbBwMgjopAYJmAQEBAQIBIxUvCwUCBQsLDgoCAiYCAlcGDQYCA?=
 =?us-ascii?q?QGCUww/AYF2BQ8PpwOBMYQyAYEUgyCBQAaBDCiLWxd4gQeBOII9Lj6CSIUGg?=
 =?us-ascii?q?lgEizGIUZQtagmCEIIbhCiMdAYbgiOKe4lqlCCRLCGBWCsIAhgIIQ+DJxIBg?=
 =?us-ascii?q?ggXiGGFWyMDMAEBAYEDAQGOewEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Jun 2019 14:05:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x56E5UlI004835;
        Thu, 6 Jun 2019 10:05:31 -0400
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
Date:   Thu, 6 Jun 2019 10:05:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3813.1559827003@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/19 9:16 AM, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> This might be easier to discuss if you can reply to:
> 
> 	https://lore.kernel.org/lkml/5393.1559768763@warthog.procyon.org.uk/
> 
> which is on the ver #2 posting of this patchset.

Sorry for being late to the party.  Not sure whether you're asking me to 
respond only there or both there and here to your comments below.  I'll 
start here but can revisit if it's a problem.
> 
>>> LSM support is included, but controversial:
>>>
>>>    (1) The creds of the process that did the fput() that reduced the refcount
>>>        to zero are cached in the file struct.
>>>
>>>    (2) __fput() overrides the current creds with the creds from (1) whilst
>>>        doing the cleanup, thereby making sure that the creds seen by the
>>>        destruction notification generated by mntput() appears to come from
>>>        the last fputter.
>>>
>>>    (3) security_post_notification() is called for each queue that we might
>>>        want to post a notification into, thereby allowing the LSM to prevent
>>>        covert communications.
>>>
>>>    (?) Do I need to add security_set_watch(), say, to rule on whether a watch
>>>        may be set in the first place?  I might need to add a variant per
>>>        watch-type.
>>>
>>>    (?) Do I really need to keep track of the process creds in which an
>>>        implicit object destruction happened?  For example, imagine you create
>>>        an fd with fsopen()/fsmount().  It is marked to dissolve the mount it
>>>        refers to on close unless move_mount() clears that flag.  Now, imagine
>>>        someone looking at that fd through procfs at the same time as you exit
>>>        due to an error.  The LSM sees the destruction notification come from
>>>        the looker if they happen to do their fput() after yours.
>>
>>
>> I'm not in favor of this approach.
> 
> Which bit?  The last point?  Keeping track of the process creds after an
> implicit object destruction.

(1), (2), (3), and the last point.

>> Can we check permission to the object being watched when a watch is set
>> (read-like access),
> 
> Yes, and I need to do that.  I think it's likely to require an extra hook for
> each entry point added because the objects are different:
> 
> 	int security_watch_key(struct watch *watch, struct key *key);
> 	int security_watch_sb(struct watch *watch, struct path *path);
> 	int security_watch_mount(struct watch *watch, struct path *path);
> 	int security_watch_devices(struct watch *watch);
> 
>> make sure every access that can trigger a notification requires a
>> (write-like) permission to the accessed object,
> 
> "write-like permssion" for whom?  The triggerer or the watcher?

The former, i.e. the process that performed the operation that triggered 
the notification.  Think of it as a write from the process to the 
accessed object, which triggers a notification (another write) on some 
related object (the watched object), which is then read by the watcher.

> There are various 'classes' of events:
> 
>   (1) System events (eg. hardware I/O errors, automount points expiring).
> 
>   (2) Direct events (eg. automounts, manual mounts, EDQUOT, key linkage).
> 
>   (3) Indirect events (eg. exit/close doing the last fput and causing an
>       unmount).
> 
> Class (1) are uncaused by a process, so I use init_cred for them.  One could
> argue that the automount point expiry should perhaps take place under the
> creds of whoever triggered it in the first place, but we need to be careful
> about long-term cred pinning.

This seems equivalent to just checking whether the watcher is allowed to 
get that kind of event, no other cred truly needed.

> Class (2) the causing process must've had permission to cause them - otherwise
> we wouldn't have got the event.

So we've already done a check on the causing process, and we're going to 
check whether the watcher can set the watch. We just need to establish 
the connection between the accessed object and the watched object in 
some manner.

> Class (3) is interesting since it's currently entirely cleanup events and the
> process may have the right to do them (close, dup2, exit, but also execve)
> whether the LSM thinks it should be able to cause the object to be destroyed
> or not.
> 
> It gets more complicated than that, though: multiple processes with different
> security attributes can all have fds pointing to a common file object - and
> the last one to close carries the can as far as the LSM is concerned.

Yes, I'd prefer to avoid that.  You can't write policy that is stable 
and meaningful that way.  This may fall under a similar situation as 
class (1) - all we can meaningfully do is check whether the watcher is 
allowed to see all such events.

> And yet more complicated when you throw in unix sockets with partially passed
> fds still in their queues.  That's what patch 01 is designed to try and cope
> with.
> 
>> and make sure there is some sane way to control the relationship between the
>> accessed object and the watched object (write-like)?
> 
> This is the trick.  Keys and superblocks have object labels of their own and
> don't - for now - propagate their watches.  With these, the watch is on the
> object you initially assign it to and it goes no further than that.
> 
> mount_notify() is the interesting case since we want to be able to detect
> mount topology change events from within the vfs subtree rooted at the watched
> directory without having to manually put a watch on every directory in that
> subtree - or even just every mount object. >
> Or, maybe, that's what I'll have to do: make it mount_notify() can only apply
> to the subtree within its superblock, and the caller must call mount_notify()
> for every mount object it wants to monitor.  That would at least ensure that
> the caller can, at that point, reach all those mount points.

Would that at least make it consistent with fanotify (not that it 
provides a great example)?

>> For cases where we have no object per se or at least no security
>> structure/label associated with it, we may have to fall back to a
>> coarse-grained "Can the watcher get this kind of notification in general?".
> 
> Agreed - and we should probably have that anyway.
> 
> David
