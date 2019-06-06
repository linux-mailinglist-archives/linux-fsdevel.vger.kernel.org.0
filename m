Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA733379ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfFFQnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 12:43:46 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:36793
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727623AbfFFQnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559839418; bh=u1sLD4QjuzjMkqUPyiTtXxaWLt0C7a5X1oo4THOAMAo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=eurZicp24AqL5vjE03WAwOO7Xa023Hhxat7TRY4VF9FKX/Nj5mAGF4alhQFJP2iE0xMXWYTfx3GUp3UwhBBvnvqRMy3y8q7Jt0M4ap4MJ//+h/Z28zC+q+E3+NZXNWDSSZBDzIJA46iB3XW9apz0d7LzHC/5th8Epy7EtUNFnVSx+ZYQYLwiiNneUP3xVbuJiYPPNCTiMI/IRzsQ+wHYrZ9C5vMh7d5T0binrqO0+Z7A+RsMTzsWV7yaf8BzIVfzx2H/fRDR95Cm55g+XoTyiCnpteZIyRF8BSMY2uw2VpA8FYjPnSSzriD3D46ZYrbPZmlHchkElwqiMO2g6Suo1A==
X-YMail-OSG: DhL2Bb4VM1kK_zeq.EWt7gTUlz9TfLTRwjo_eHNbXy7c8Ge_T_QOznpbaqEnm5E
 2qo2oYmnH8VmT_.PRDU0gk3l.VMbJ2DjRvQY.DPmUtS8EATiheMTRQw_S5tNZOdDbMu0mmcbU81j
 EKTyT1rY910A44SK2KxjLZOU4t9c4_hS5l0_2tHCPPqnZ8Dry7lHCVMMpfoVzviHsEVJQcIeiPYa
 RwqlgyOVAj7lxAgidlnSHGahTQJOyp0Qe0l1O2TIdTgD9x7KhaBkVXlW5dmPU2E8jj19fHi2boVP
 V3zxiyEyw63qaAWU6hyhGmmyX1k6trk2knUsMrpt2JL7PuvPEWjsdrECskcmIRNaAyaHvQ.L8sIj
 3Nwe75a.PMfDriN7Qm.yvvSYuDvRypPzf8GFJ4qIpTGfIpPpWuHvR6nq1OYAaRPskSWLF57k9Cmq
 OcXKbx2iHsgUr00Zm4wJh7CxWYzGOhVb3vRgnzRZuKpUCjPFH5lezVr6NpZEch73K5O0ewnbcaKj
 xzmA65dyuCTAEyBBASVLEv2p9lntlltDnQQ9jDg6XpyRALZhjTiyix53U97V_NNPnK_0iKlUw1iC
 DyU8Lrg6RvlAVKVfw9EgXUAm2w40aU_zDspncuYUH5uKxXOR08TnJZ2es5eK5pIZtlDjefH1QhtT
 PHbi79D7_1E.staNDSkyTh6Y53Voyv2RGANRkinLs8dy3SO5sn7F0v8Kpq4pquwGs15uUsFDlPW5
 qNgwTDMva6tO.tX7mrhKe_6xHhOCMmRFNnLTE.oNlxifrl19yy7WcQuylHFUoqNp31KsoFZyMNkv
 RpW4v7hRnKGlEsnTg_27mu2f5t3T8qb6X4.mg0JG4U2RAgTUeBLS5FiH7iLYyE71TLmPC0iaXNbO
 J46S5cIZdwqmq4IvvfluUcUaWsh35Xy.g4WNDvLvmDhElJr2KL9Ohan20UfQMW.XXGD2NqJu4PwS
 kD33OTDa6clf45oH0qhKnxSvIGedvVSKxgcR5dKf4_r_hDJK.ZLdjViQ4mor6eZBHx4ATknIm1Cf
 w103UsQJCxjq93PpP7ZiI.RIYwRgjVrEq1der7yWmZkRpBSObLJzQfV90yvAfe8GVcR_3cEoEP_m
 ZC1EF26dKHbO2ali3O3qwItLWu0WMOwaXeyCZsc7MuEWvJPbtG5BkseBx2LBkRFdWRLJ.SmkIt9E
 NFvjWyDul4rzytGbxlhpJUIHPB0gyNrgdO1QeAgpbZ9h4bG_PqFcO.7ODxFtm13cX2i1ncqYmDy5
 lyBBVLhHzvTl7vgBtkGkjUdh1iSFVYNSKP0c3Yf1Adr0y0JuUeAnT3zqjK255dhp1NyDR5u9CqWe
 VTIk43m_Lcq1F
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Jun 2019 16:43:38 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2931d6e1562697920eada9c26d4dfc98;
          Thu, 06 Jun 2019 16:43:37 +0000 (UTC)
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        casey@schaufler-ca.com
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk>
 <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 09:43:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/2019 7:05 AM, Stephen Smalley wrote:
> On 6/6/19 9:16 AM, David Howells wrote:
>> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> This might be easier to discuss if you can reply to:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0https://lore.kernel.org/lkml/5393.1559768763@w=
arthog.procyon.org.uk/
>>
>> which is on the ver #2 posting of this patchset.
>
> Sorry for being late to the party.=C2=A0 Not sure whether you're asking=
 me to respond only there or both there and here to your comments below.=C2=
=A0 I'll start here but can revisit if it's a problem.
>>
>>>> LSM support is included, but controversial:
>>>>
>>>> =C2=A0=C2=A0 (1) The creds of the process that did the fput() that r=
educed the refcount
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to zero are cached in the file =
struct.
>>>>
>>>> =C2=A0=C2=A0 (2) __fput() overrides the current creds with the creds=
 from (1) whilst
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doing the cleanup, thereby maki=
ng sure that the creds seen by the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destruction notification genera=
ted by mntput() appears to come from
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the last fputter.
>>>>
>>>> =C2=A0=C2=A0 (3) security_post_notification() is called for each que=
ue that we might
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 want to post a notification int=
o, thereby allowing the LSM to prevent
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 covert communications.
>>>>
>>>> =C2=A0=C2=A0 (?) Do I need to add security_set_watch(), say, to rule=
 on whether a watch
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 may be set in the first place?=C2=
=A0 I might need to add a variant per
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watch-type.
>>>>
>>>> =C2=A0=C2=A0 (?) Do I really need to keep track of the process creds=
 in which an
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 implicit object destruction hap=
pened?=C2=A0 For example, imagine you create
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 an fd with fsopen()/fsmount().=C2=
=A0 It is marked to dissolve the mount it
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refers to on close unless move_=
mount() clears that flag.=C2=A0 Now, imagine
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 someone looking at that fd thro=
ugh procfs at the same time as you exit
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 due to an error.=C2=A0 The LSM =
sees the destruction notification come from
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the looker if they happen to do=
 their fput() after yours.
>>>
>>>
>>> I'm not in favor of this approach.
>>
>> Which bit?=C2=A0 The last point?=C2=A0 Keeping track of the process cr=
eds after an
>> implicit object destruction.
>
> (1), (2), (3), and the last point.
>
>>> Can we check permission to the object being watched when a watch is s=
et
>>> (read-like access),
>>
>> Yes, and I need to do that.=C2=A0 I think it's likely to require an ex=
tra hook for
>> each entry point added because the objects are different:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0int security_watch_key(struct watch *watch, st=
ruct key *key);
>> =C2=A0=C2=A0=C2=A0=C2=A0int security_watch_sb(struct watch *watch, str=
uct path *path);
>> =C2=A0=C2=A0=C2=A0=C2=A0int security_watch_mount(struct watch *watch, =
struct path *path);
>> =C2=A0=C2=A0=C2=A0=C2=A0int security_watch_devices(struct watch *watch=
);
>>
>>> make sure every access that can trigger a notification requires a
>>> (write-like) permission to the accessed object,
>>
>> "write-like permssion" for whom?=C2=A0 The triggerer or the watcher?
>
> The former, i.e. the process that performed the operation that triggere=
d the notification.=C2=A0 Think of it as a write from the process to the =
accessed object, which triggers a notification (another write) on some re=
lated object (the watched object), which is then read by the watcher.

We agree that the process that performed the operation that triggered
the notification is the initial subject. Smack will treat the process
with the watch set (in particular, its ring buffer) as the object
being written to. SELinux, with its finer grained controls, will
involve other things as noted above. There are other place where we
see this, notably IP packet delivery.

The implication is that the information about the triggering
process needs to be available throughout.

>
>> There are various 'classes' of events:
>>
>> =C2=A0 (1) System events (eg. hardware I/O errors, automount points ex=
piring).
>>
>> =C2=A0 (2) Direct events (eg. automounts, manual mounts, EDQUOT, key l=
inkage).
>>
>> =C2=A0 (3) Indirect events (eg. exit/close doing the last fput and cau=
sing an
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unmount).
>>
>> Class (1) are uncaused by a process, so I use init_cred for them.=C2=A0=
 One could
>> argue that the automount point expiry should perhaps take place under =
the
>> creds of whoever triggered it in the first place, but we need to be ca=
reful
>> about long-term cred pinning.
>
> This seems equivalent to just checking whether the watcher is allowed t=
o get that kind of event, no other cred truly needed.
>
>> Class (2) the causing process must've had permission to cause them - o=
therwise
>> we wouldn't have got the event.
>
> So we've already done a check on the causing process, and we're going t=
o check whether the watcher can set the watch. We just need to establish =
the connection between the accessed object and the watched object in some=
 manner.

I don't agree. That is, I don't believe it is sufficient.
There is no guarantee that being able to set a watch on an
object implies that every process that can trigger the event
can send it to you.

	Watcher has Smack label W
	Triggerer has Smack label T
	Watched object has Smack label O

	Relevant Smack rules are

	W O rw
	T O rw

The watcher will be able to set the watch,
the triggerer will be able to trigger the event,
but there is nothing that would allow the watcher
to receive the event. This is not a case of watcher
reading the watched object, as the event is delivered
without any action by watcher.

>
>> Class (3) is interesting since it's currently entirely cleanup events =
and the
>> process may have the right to do them (close, dup2, exit, but also exe=
cve)
>> whether the LSM thinks it should be able to cause the object to be des=
troyed
>> or not.
>>
>> It gets more complicated than that, though: multiple processes with di=
fferent
>> security attributes can all have fds pointing to a common file object =
- and
>> the last one to close carries the can as far as the LSM is concerned.
>
> Yes, I'd prefer to avoid that.=C2=A0 You can't write policy that is sta=
ble and meaningful that way.=C2=A0 This may fall under a similar situatio=
n as class (1) - all we can meaningfully do is check whether the watcher =
is allowed to see all such events.

Back in the day when we were doing security evaluations
the implications of "deleting" an object gave the security
evaluators fits. UNIX/Linux files don't get deleted, they
simply fall off the filesystem namespace when no one cares
about them anymore. The model we used back in the day was
that "delete" wasn't an operation that occurs on filesystem
objects.

But now you want to do something with security implications
when the object disappears. We could say that the event does
nothing but signal that the system has removed the watch on
your behalf because it is now meaningless. No reason to worry
about who dropped the last reference. We don't care about
that from a policy viewpoint anyway.

>
>> And yet more complicated when you throw in unix sockets with partially=
 passed
>> fds still in their queues.=C2=A0 That's what patch 01 is designed to t=
ry and cope
>> with.
>>
>>> and make sure there is some sane way to control the relationship betw=
een the
>>> accessed object and the watched object (write-like)?
>>
>> This is the trick.=C2=A0 Keys and superblocks have object labels of th=
eir own and
>> don't - for now - propagate their watches.=C2=A0 With these, the watch=
 is on the
>> object you initially assign it to and it goes no further than that.
>>
>> mount_notify() is the interesting case since we want to be able to det=
ect
>> mount topology change events from within the vfs subtree rooted at the=
 watched
>> directory without having to manually put a watch on every directory in=
 that
>> subtree - or even just every mount object. >
>> Or, maybe, that's what I'll have to do: make it mount_notify() can onl=
y apply
>> to the subtree within its superblock, and the caller must call mount_n=
otify()
>> for every mount object it wants to monitor.=C2=A0 That would at least =
ensure that
>> the caller can, at that point, reach all those mount points.
>
> Would that at least make it consistent with fanotify (not that it provi=
des a great example)?
>
>>> For cases where we have no object per se or at least no security
>>> structure/label associated with it, we may have to fall back to a
>>> coarse-grained "Can the watcher get this kind of notification in gene=
ral?".
>>
>> Agreed - and we should probably have that anyway.
>>
>> David

