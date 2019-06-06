Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE737B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfFFR1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 13:27:41 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:31399 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbfFFR1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:27:41 -0400
X-Greylist: delayed 653 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 13:27:37 EDT
X-EEMSG-check-017: 230639275|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jun 2019 17:16:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559841401; x=1591377401;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IqCMcIgF6Z/D0YOg9kRlQDInwlPNM0gC3vhPg/4/dB8=;
  b=Eq/JZxU/WtXBU+fgeoBSrl+e50v6dDSLEYqSst6jPQLtypvHYjJY/KS5
   g5sFGpX0EDWpPtPIWIs6nRDbXf3ia+508jrYoCZGzrTGGIb1n5PMSxjap
   EVxFlK03BHa5rvj9KevdAnm+PfAlN4WnafuUUbmuqANWnBVcdpKcpm7kg
   pFBwwAwTpIv3NnzYes7UNtG+aKQmB9zGxrdRUEc1C2USs0nYHujg2FaUC
   DN/35CjG3M+tn7/M+ps6HcpgCz6g+Fq9n1qil7Zg1JJxFI0P9YeY8pQnu
   61cZVKEceoIBw21u4rcnd/3PXWzBV9smNgNzc4b/jl58vxaPN1Q0R0J2o
   A==;
X-IronPort-AV: E=Sophos;i="5.63,560,1557187200"; 
   d="scan'208";a="28656036"
IronPort-PHdr: =?us-ascii?q?9a23=3AQTQHihFSCiGJbzUjNwE9O51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76ocu9bnLW6fgltlLVR4KTs6sC17OP9fm8BSdZuM/JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQi6oR/MusQZjoZuJbs9xg?=
 =?us-ascii?q?bUrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAehCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbP5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSg0yroDuZ?=
 =?us-ascii?q?GhfSgKzowqxx3BZPyddYiH/BbjWPyWITdii3Jofq+0iRWq8UW41+HxWca53E?=
 =?us-ascii?q?xKoyZYiNXAqH8A2wLJ5sSaTPZ2412v1iyV1w/J7+FJOUU0la3GJJE/2rMwjZ?=
 =?us-ascii?q?8TsVjbHi/xhUX2kLeadkU69eis7OTqeqnmqYWGN491lwH+Kb4imtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKg27344UL1WrBKjvwykqXBsZDaI9oUprKhDgNI3Ysu5AyzAje73N?=
 =?us-ascii?q?gCg3UKI0xJdAiag4TxPlHBOvH4DfOxg1S2lzdrwujLPqb8DZXWNXXDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8tf6IhOBrEOJ/LzRFf9tMbEAR8hLwy03+HnBc1h2YwEQmKAHK?=
 =?us-ascii?q?+YPbjJsVCU5uIgOfSMZIERuDnjMfgp/uLhgmUjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88cHmcKuQo/QvLliFmGUT5IfHuyRbwz6Sw7CI28EYfPXJyigLuE3C?=
 =?us-ascii?q?2jBJ1ZenhGCkyQEXfvb4iERfYMaDiVIsJ6kz0LS76hS44/1R20sA/6yrxnLv?=
 =?us-ascii?q?fb+yECspLjztd16/fOlREx7TZ0FdiS03mRT2FomWMFXzA23LphrkxyyVeD0b?=
 =?us-ascii?q?N1g/hZFdxV+vNIXQk6NZnBz+x8Ft/9QB7BftaOSFagWNmmBisxTt0pyd8Uf0?=
 =?us-ascii?q?l9A8mijgzE3yeyB78VlrqLBIE7867FwnjxPN1yxm3Y1KkukVYmWNFDNW64ia?=
 =?us-ascii?q?5l8QjcGYrJn1+el6aweqQWxDTN+3ubzWqSoEFYVxZ9Ub/fUnABeETWq8/05l?=
 =?us-ascii?q?/CT7CwDLQoKAVAxdSEKqRUdt3jlU9GS+v7ONTCf2KxnH+9BRKJxrOKcYrrdH?=
 =?us-ascii?q?wR3CvGCEcZjQ8T42iJNQwlCye/rGLREiZuGUjsY0zy6+l+rm20TksuwwGNdU?=
 =?us-ascii?q?1h2KK/+gQJivyEV/MTwrUEtT8lqzV1Gla9wt3XB8OaqAp5faVRes094FhZ2m?=
 =?us-ascii?q?LDrQB9PYKvL7pkhlEAdwR7pUTu1w94Co9Yi8glsGsqzBZuKaKfyF5BczKY3Z?=
 =?us-ascii?q?btOrzYM2X95xSva6nK1VHdy9uW5KgP5+oiq1n5vwGmCFAi83N53NlRyXec4Y?=
 =?us-ascii?q?/KDAUKW5LrTkk37wR6p63dYiQl5IPby31tMbO1sj/E1NIpH/Aoygivf9hBKq?=
 =?us-ascii?q?OIDgzyHNMAB8ioNuMqn0KlbhUePOBd7KQ0Jd+pd+Oa2K63O+ZthDamjWVB4I?=
 =?us-ascii?q?Bg3UOA7jF8RfDU0JYY2fGY3xeHVjflgFektcD4hJ1EZTUMEWek1yjkC5BeZr?=
 =?us-ascii?q?docYYIF2iuOcu3yct6h5L3XH5Y7lGjDUsc2MC1YRqSc0D93QpI2EQToHynnz?=
 =?us-ascii?q?a4zjNtnzEqsKWfxirOzPrmdBccJG5LS3dtjU32LYi3kd8aRk6oYBYtlBe/4k?=
 =?us-ascii?q?b63adbrrxlL2bPWUdIYzT2L2Z6X6uorLWCfspP5YgwsSpNTeS8ZUmWSrv6ox?=
 =?us-ascii?q?sdySPsAXFSyyw8dzGv6d3FmElRgXmQPT5Ip3rQZM90yA2XsNfVXvNA9iENRC?=
 =?us-ascii?q?Blhz3aHB23Np+i+tDC09/vu/6/WyqBUYJedS3whdeMtCyk6GluGjWlkvyzk8?=
 =?us-ascii?q?GhGg8/h3zVzd5vAB7UoQ78b4+j7KGzNeZqbwE8H1Pnw9ZrEYF51I0rjdcf3m?=
 =?us-ascii?q?ZM1cbdxmYOjWqmaYYT4qn5dndYAGdQktM=3D?=
X-IPAS-Result: =?us-ascii?q?A2AzAwCcSflc/wHyM5BlHAEBAQQBAQcEAQGBZYFnKmpRA?=
 =?us-ascii?q?TIohBSSck0BAQEBAQaBNYlRjyKBZwkBAQEBAQEBAQErCQECAQGEQAKCYyM4E?=
 =?us-ascii?q?wEDAQEBBAEBAQEDAQFsHAyCOikBgmcBAgMjDwEFLwsFAhAJAhgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBglMMPwGBdhQPi1CbaoExhDIBgRSDIYFABoEMKItbF3iBB4E4gj0uP?=
 =?us-ascii?q?oJIgWSDIoJYBIsxnH5qCYIQghuEKIx0BhuCI4p7iWqNDocSkSwhgVgrCAIYC?=
 =?us-ascii?q?CEPgycSAYIIF4ECAQ6HUIVbIwMwAQEBgQMBAY52AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Jun 2019 17:16:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x56HGaTA005569;
        Thu, 6 Jun 2019 13:16:37 -0400
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk>
 <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
 <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov>
Date:   Thu, 6 Jun 2019 13:16:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/19 12:43 PM, Casey Schaufler wrote:
> On 6/6/2019 7:05 AM, Stephen Smalley wrote:
>> On 6/6/19 9:16 AM, David Howells wrote:
>>> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> This might be easier to discuss if you can reply to:
>>>
>>>      https://lore.kernel.org/lkml/5393.1559768763@warthog.procyon.org.uk/
>>>
>>> which is on the ver #2 posting of this patchset.
>>
>> Sorry for being late to the party.  Not sure whether you're asking me to respond only there or both there and here to your comments below.  I'll start here but can revisit if it's a problem.
>>>
>>>>> LSM support is included, but controversial:
>>>>>
>>>>>     (1) The creds of the process that did the fput() that reduced the refcount
>>>>>         to zero are cached in the file struct.
>>>>>
>>>>>     (2) __fput() overrides the current creds with the creds from (1) whilst
>>>>>         doing the cleanup, thereby making sure that the creds seen by the
>>>>>         destruction notification generated by mntput() appears to come from
>>>>>         the last fputter.
>>>>>
>>>>>     (3) security_post_notification() is called for each queue that we might
>>>>>         want to post a notification into, thereby allowing the LSM to prevent
>>>>>         covert communications.
>>>>>
>>>>>     (?) Do I need to add security_set_watch(), say, to rule on whether a watch
>>>>>         may be set in the first place?  I might need to add a variant per
>>>>>         watch-type.
>>>>>
>>>>>     (?) Do I really need to keep track of the process creds in which an
>>>>>         implicit object destruction happened?  For example, imagine you create
>>>>>         an fd with fsopen()/fsmount().  It is marked to dissolve the mount it
>>>>>         refers to on close unless move_mount() clears that flag.  Now, imagine
>>>>>         someone looking at that fd through procfs at the same time as you exit
>>>>>         due to an error.  The LSM sees the destruction notification come from
>>>>>         the looker if they happen to do their fput() after yours.
>>>>
>>>>
>>>> I'm not in favor of this approach.
>>>
>>> Which bit?  The last point?  Keeping track of the process creds after an
>>> implicit object destruction.
>>
>> (1), (2), (3), and the last point.
>>
>>>> Can we check permission to the object being watched when a watch is set
>>>> (read-like access),
>>>
>>> Yes, and I need to do that.  I think it's likely to require an extra hook for
>>> each entry point added because the objects are different:
>>>
>>>      int security_watch_key(struct watch *watch, struct key *key);
>>>      int security_watch_sb(struct watch *watch, struct path *path);
>>>      int security_watch_mount(struct watch *watch, struct path *path);
>>>      int security_watch_devices(struct watch *watch);
>>>
>>>> make sure every access that can trigger a notification requires a
>>>> (write-like) permission to the accessed object,
>>>
>>> "write-like permssion" for whom?  The triggerer or the watcher?
>>
>> The former, i.e. the process that performed the operation that triggered the notification.  Think of it as a write from the process to the accessed object, which triggers a notification (another write) on some related object (the watched object), which is then read by the watcher.
> 
> We agree that the process that performed the operation that triggered
> the notification is the initial subject. Smack will treat the process
> with the watch set (in particular, its ring buffer) as the object
> being written to. SELinux, with its finer grained controls, will
> involve other things as noted above. There are other place where we
> see this, notably IP packet delivery.
> 
> The implication is that the information about the triggering
> process needs to be available throughout.
> 
>>
>>> There are various 'classes' of events:
>>>
>>>    (1) System events (eg. hardware I/O errors, automount points expiring).
>>>
>>>    (2) Direct events (eg. automounts, manual mounts, EDQUOT, key linkage).
>>>
>>>    (3) Indirect events (eg. exit/close doing the last fput and causing an
>>>        unmount).
>>>
>>> Class (1) are uncaused by a process, so I use init_cred for them.  One could
>>> argue that the automount point expiry should perhaps take place under the
>>> creds of whoever triggered it in the first place, but we need to be careful
>>> about long-term cred pinning.
>>
>> This seems equivalent to just checking whether the watcher is allowed to get that kind of event, no other cred truly needed.
>>
>>> Class (2) the causing process must've had permission to cause them - otherwise
>>> we wouldn't have got the event.
>>
>> So we've already done a check on the causing process, and we're going to check whether the watcher can set the watch. We just need to establish the connection between the accessed object and the watched object in some manner.
> 
> I don't agree. That is, I don't believe it is sufficient.
> There is no guarantee that being able to set a watch on an
> object implies that every process that can trigger the event
> can send it to you.
> 
> 	Watcher has Smack label W
> 	Triggerer has Smack label T
> 	Watched object has Smack label O
> 
> 	Relevant Smack rules are
> 
> 	W O rw
> 	T O rw
> 
> The watcher will be able to set the watch,
> the triggerer will be able to trigger the event,
> but there is nothing that would allow the watcher
> to receive the event. This is not a case of watcher
> reading the watched object, as the event is delivered
> without any action by watcher.

You are allowing arbitrary information flow between T and W above.  Who 
cares about notifications?

How is it different from W and T mapping the same file as a shared 
mapping and communicating by reading and writing the shared memory?  You 
aren't performing a permission check directly between W and T there.

> 
>>
>>> Class (3) is interesting since it's currently entirely cleanup events and the
>>> process may have the right to do them (close, dup2, exit, but also execve)
>>> whether the LSM thinks it should be able to cause the object to be destroyed
>>> or not.
>>>
>>> It gets more complicated than that, though: multiple processes with different
>>> security attributes can all have fds pointing to a common file object - and
>>> the last one to close carries the can as far as the LSM is concerned.
>>
>> Yes, I'd prefer to avoid that.  You can't write policy that is stable and meaningful that way.  This may fall under a similar situation as class (1) - all we can meaningfully do is check whether the watcher is allowed to see all such events.
> 
> Back in the day when we were doing security evaluations
> the implications of "deleting" an object gave the security
> evaluators fits. UNIX/Linux files don't get deleted, they
> simply fall off the filesystem namespace when no one cares
> about them anymore. The model we used back in the day was
> that "delete" wasn't an operation that occurs on filesystem
> objects.
> 
> But now you want to do something with security implications
> when the object disappears. We could say that the event does
> nothing but signal that the system has removed the watch on
> your behalf because it is now meaningless. No reason to worry
> about who dropped the last reference. We don't care about
> that from a policy viewpoint anyway.
> 
>>
>>> And yet more complicated when you throw in unix sockets with partially passed
>>> fds still in their queues.  That's what patch 01 is designed to try and cope
>>> with.
>>>
>>>> and make sure there is some sane way to control the relationship between the
>>>> accessed object and the watched object (write-like)?
>>>
>>> This is the trick.  Keys and superblocks have object labels of their own and
>>> don't - for now - propagate their watches.  With these, the watch is on the
>>> object you initially assign it to and it goes no further than that.
>>>
>>> mount_notify() is the interesting case since we want to be able to detect
>>> mount topology change events from within the vfs subtree rooted at the watched
>>> directory without having to manually put a watch on every directory in that
>>> subtree - or even just every mount object. >
>>> Or, maybe, that's what I'll have to do: make it mount_notify() can only apply
>>> to the subtree within its superblock, and the caller must call mount_notify()
>>> for every mount object it wants to monitor.  That would at least ensure that
>>> the caller can, at that point, reach all those mount points.
>>
>> Would that at least make it consistent with fanotify (not that it provides a great example)?
>>
>>>> For cases where we have no object per se or at least no security
>>>> structure/label associated with it, we may have to fall back to a
>>>> coarse-grained "Can the watcher get this kind of notification in general?".
>>>
>>> Agreed - and we should probably have that anyway.
>>>
>>> David
> 

