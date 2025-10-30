Return-Path: <linux-fsdevel+bounces-66500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B8C213EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2C274EE1B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F82DE1E0;
	Thu, 30 Oct 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3J6CJlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523627F00A;
	Thu, 30 Oct 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842307; cv=none; b=GxKrBUmh7YHpP/9dcyrn6ii7gGxsoWkix7K5OtIOyFovMBZc45Y9q/aXJXeOp0hc0IQsNb/0+6D5DnzF5Og5eBropUaqJISjdVxAt17U1SYb6BbLJteIxvDTW/HzUAW63VoRBo7R9vVlHMx8VXou4LCO4k2M0CYrM9Xhu7ogW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842307; c=relaxed/simple;
	bh=U30GzCcZQSgByZ0Vk2dS8MT2M8hgaMbL/AWaAA+Wu1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA6TulgtbeghnonvmnqwjvgLArKT0GiHSN8IH9OdkP+6JKNBcskCMS+nLLTkrlaG8FliLn42nO0OPfiPjAD7Nn3vN+aO9JFjKIfHePJ52dW8WXSdWD+fVhN4WW48xgAsGw7O9R0jUd4pncS2Z99RBPyIhCnKDXdHhxSL3BagX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3J6CJlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FEFC4CEF1;
	Thu, 30 Oct 2025 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842307;
	bh=U30GzCcZQSgByZ0Vk2dS8MT2M8hgaMbL/AWaAA+Wu1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3J6CJlGSP8KX1d+g0H0JNHswvddpr2dMeOqhfQO63WmjehcCyjRGNNslVVf0D4Zs
	 OBo2Uhxuf/6h1yvRJW0T7PY6kpJG6MD0jLDiKtlIHX9nvyATngpJLuOSRdWhqXi5lE
	 wCcleWjxhLu6gsAGAFZ6AG7f4nzzd5Jex/fG5rJEPMMQF2qfwmaJDh1V1k8EU2TVN/
	 oacitd/0yRou5ofT1qg70NumZDvjExmns2G5OmSu1xiHImqXmCNpCilj21AT0BBfLt
	 kdd+nCZN5Zm8Ssg1r3I3mRtQSJXcito+eVEwdk0JWUY2WEFridezT1whkhdXzBdHwo
	 swmMxLwyyyDrA==
Date: Thu, 30 Oct 2025 09:38:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/19] docs: discuss autonomous self healing in the xfs
 online repair design doc
Message-ID: <20251030163826.GN3356773@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
 <176117744541.1025409.747197958715254738.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176117744541.1025409.747197958715254738.stgit@frogsfrogsfrogs>

On Wed, Oct 22, 2025 at 05:01:07PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Update the XFS online repair document to describe the motivation and
> design of the autonomous filesystem healing agent known as xfs_healer.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

/me decides (or rather it was pointed out to me) that there's a kernel
component to xfs_healer, but no explicit discussion of it in section 5
("Kernel Algorithms and Data Structures").  Also given the frequency of
the question "why not reuse fsnotify?" I'll address the reasons for that
here.

I've added the following text, which will appear in the next revision:

 5. Kernel Algorithms and Data Structures
 ========================================

<snip>

+Health Monitoring
+-----------------
+
+A self-correcting filesystem responds to observations of problems by scheduling
+repairs of the affected areas.
+The filesystem must therefore create event objects in response to stimuli
+(metadata corruption, file I/O errors, etc.) and dispatch these events to
+downstream consumers.
+Downstream consumers that are in the kernel itself are easy to implement with
+the ``xfs_hooks`` infrastructure created for other parts of online repair; these
+are basically indirect function calls.
+
+However, the decision to translate an adverse metadata health report into a
+repair should be made by userspace, and the actual scheduling done by userspace.
+Some users (e.g. containers) would prefer to fast-fail the container and restart
+it on another node at a previous checkpoint.
+For workloads running in isolation, repairs may be preferable; either way this
+is something the system administrator knows, and not the kernel.
+A userspace agent (``xfs_healer``, described later) will collect events from the
+kernel and dispatch them appropriately.
+
+Exporting health events to userspace requires the creation of a new component,
+known as the health monitor.
+Because the monitor exposes itself to userspace to deliver information, a file
+descriptor is the natural abstraction to use here.
+The health monitor hooks all the relevant sources of metadata health events.
+Upon activation of the hook, a new event object is created and added to a queue.
+When the agent reads from the fd, event objects are pulled from the start of the
+queue and formatted into the user's buffer.
+The events are freed, and the read call returns to userspace to allow the agent
+to perform some work.
+Memory usage is constrained on a per-fd basis to prevent memory exhaustion; if
+an event must be discarded, a special "lost event" event is delivered to the
+agent.
+
+In short, health events are captured, queued, and eventually copied out to
+userspace for dispatching.
+
+**Question**: Why use a pseudofile and not use existing notification methods?
+
+*Answer*: The pseudofile is a private filesystem interface only available to
+processes with the CAP_SYS_ADMIN priviledge and the ability to open the root
+directory.
+Being private gives the kernel and ``xfs_healer`` the flexibility to change
+or update the event format in the future without worrying about backwards
+compatibility.
+Using existing notifications means that the event format would be frozen in
+the public fsnotify UAPI forever, which would affect two subsystems.
+
+The pseudofile can also accept ioctls, which gives ``xfs_healer`` a solid
+means to validate that prior to a repair, its reopened mountpoint is actually
+the same filesystem that is being monitored.
+
+**Question**: Why not reuse fs/notify?
+
+*Answer*: It's much simpler for the healthmon code to manage its own queue of
+events and to wake up readers instead of reusing fsnotify because that's the
+only part of fsnotify that would use.
+
+Before I get started, an introduction: fsnotify expects its users (e.g.
+fanotify) to implement quite a bit of functionality; all it provides is a
+wrapper around a simple queue and a lot of code to convey information about the
+calling process to that user.
+fanotify has to actually implement all the queue management code on its own,
+and so would healthmon.
+
+So if healthmon used fsnotify, it would have to create its own fsnotify group
+structure.
+For our purposes, the group is a very large wrapper around a linked list, some
+counters, and a mutex.
+The group object is critical for ensuring that sees only its own events, and
+that nobody else (e.g. regular fanotify) ever sees these events.
+There's a lot more in there for controlling whether fanotify reports pids,
+groups, file handles, etc. that healthmon doesn't care about.
+
+Starting from the fsnotify() function call:
+
+ - I /think/ we'd have to define a new "data type", which itself is just a plain
+   int but I think they correspond to FSNOTIFY_EVENT_* values which themselves
+   are actually part of an enum.
+   The data type controls the typecasting options for the ``void *data``
+   parameter, which I guess is how I'd pass the healthmon event info from the
+   hooks into the fsnotify mechanism and back out to the healthmon code.
+
+ - Each filesystem that wants to do this probably has to add their own
+   FSNOTIFY_EVENT_{XFS,BTRFS,BFS} data type value because that's a casting
+   decision that's made inside the main fsnotify code.
+   I think this can be avoided if each fs is careful never to leak events
+   outside of the group.
+   Either way, it's harder to follow the data flows here because fsnotify can
+   only take and pass around ``void *`` pointers, and it makes various indirect
+   function calls to manage events.
+   Contrast this with doing everything with typed pointers and direct calls
+   within ``xfs_healthmon.c``.
+
+ - Since healthmon is both producer and consumer of fsnotify events, we can
+   probably define our own "mask" value.
+   It's a relief that we don't have to interact with fanotify, because fanotify
+   has used up 22 of its 32 mask bits.
+
+Once healthmon gets an event into fsnotify, fsnotify will call back (into
+healthmon!) to tell it that it got an event.
+From there, the fsnotify implementation (healthmon) has to allocate an event
+object and add it to the event queue in the group, which is what it already does
+now.
+Overflow control is up to the fsnotify implementation, which healthmon already
+implements.
+
+After the event is queued, the fsnotify implementation also has to implement its
+own read file op to dequeue an event and copy it to the userspace buffer in
+whatever format it likes.
+Again, healthmon already does all this.
+
+In the end, replacing the homegrown event dispatching in healthmon with fsnotify
+would make the data flows much harder to understand, and all we gain is a
+generic event dispatcher that relies on indirect function calls instead of
+direct ones.
+We still have to implement the queuing discipline ourselves! :(
+
+**Future Work Question**: Should these events be exposed through the fanotify
+filesystem error event interface?
+
+*Answer*: Yes.
+fanotify is much more careful about filtering out events to processes that
+aren't running with privileges.
+These processes should have a means to receive simple notifications about
+file errors.
+However, this will require coordination between fanotify, ext4, and XFS, and
+is (for now) outside the scope of this project.

--D

> ---
>  .../filesystems/xfs/xfs-online-fsck-design.rst     |  102 ++++++++++++++++++++
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> index 189d1f5f40788d..bdbf338a9c9f0c 100644
> --- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> @@ -166,9 +166,12 @@ The current XFS tools leave several problems unsolved:
>     malicious actors **exploit quirks of Unicode** to place misleading names
>     in directories.
>  
> +8. **Site Reliability and Support Engineers** would like to reduce the
> +   frequency of incidents requiring **manual intervention**.
> +
>  Given this definition of the problems to be solved and the actors who would
>  benefit, the proposed solution is a third fsck tool that acts on a running
> -filesystem.
> +filesystem, and an autononmous agent that fixes problems as they arise.
>  
>  This new third program has three components: an in-kernel facility to check
>  metadata, an in-kernel facility to repair metadata, and a userspace driver
> @@ -203,6 +206,13 @@ Even if a piece of filesystem metadata can only be regenerated by scanning the
>  entire system, the scan can still be done in the background while other file
>  operations continue.
>  
> +The autonomous self healing agent should listen for metadata health impact
> +reports coming from the kernel and automatically schedule repairs for the
> +damaged metadata.
> +If the required repairs are larger in scope than a single metadata structure,
> +``xfs_scrub`` should be invoked to perform a full analysis.
> +``xfs_healer`` is the name of this program.
> +
>  In summary, online fsck takes advantage of resource sharding and redundant
>  metadata to enable targeted checking and repair operations while the system
>  is running.
> @@ -850,11 +860,16 @@ variable in the following service files:
>  * ``xfs_scrub_all_fail.service``
>  
>  The decision to enable the background scan is left to the system administrator.
> -This can be done by enabling either of the following services:
> +This can be done system-wide by enabling either of the following services:
>  
>  * ``xfs_scrub_all.timer`` on systemd systems
>  * ``xfs_scrub_all.cron`` on non-systemd systems
>  
> +To enable online repair for specific filesystems, the ``autofsck``
> +filesystem property should be set to ``repair``.
> +To enable only scanning, the property should be set to ``check``.
> +To disable online fsck entirely, the property should be set to ``none``.
> +
>  This automatic weekly scan is configured out of the box to perform an
>  additional media scan of all file data once per month.
>  This is less foolproof than, say, storing file data block checksums, but much
> @@ -897,6 +912,36 @@ notifications and initiate a repair?
>  *Answer*: These questions remain unanswered, but should be a part of the
>  conversation with early adopters and potential downstream users of XFS.
>  
> +Autonomous Self Healing
> +-----------------------
> +
> +The autonomous self healing agent is a background system service that starts
> +when the filesystem is mounted and runs until unmount.
> +When starting up, the agent opens a special pseudofile under the specific
> +mount.
> +When the filesystem generates new adverse health events, the events will be
> +made available for reading via the special pseudofile.
> +The events need not be limited to metadata concerns; they can also reflect
> +events outside of the filesystem's direct control such as file I/O errors.
> +
> +The agent reads these events in a loop and responds to the events
> +appropriately.
> +For a single trouble report about metadata, the agent initiates a targeted
> +repair of the specific structure.
> +If that repair fails or the agent observes too many metadata trouble reports
> +over a short interval, it should then initiate a full scan of the filesystem
> +via the ``xfs_scrub`` service.
> +
> +The decision to enable the background scan is left to the system administrator.
> +This can be done system-wide by enabling the following services:
> +
> +* ``xfs_healer@.service`` on systemd systems
> +
> +To enable autonomous healing for specific filesystems, the ``autofsck``
> +filesystem property should be set to ``repair``.
> +To disable self healing, the property should be set to ``check``,
> +``optimize``, or ``none``.
> +
>  5. Kernel Algorithms and Data Structures
>  ========================================
>  
> @@ -5071,6 +5116,59 @@ and report what has been lost.
>  For media errors in blocks owned by files, parent pointers can be used to
>  construct file paths from inode numbers for user-friendly reporting.
>  
> +Autonomous Self Healing
> +-----------------------
> +
> +When a filesystem mounts, the Linux kernel initiates a uevent describing the
> +mount and the path to the data device.
> +A udev rule determines the initial mountpoint from the data device path
> +and starts a mount-specific ``xfs_healer`` service instance.
> +The ``xfs_healer`` service opens the mountpoint and issues the
> +XFS_IOC_HEALTH_MONITOR ioctl to open a special health monitoring file.
> +After that is set up, the mountpoint is closed to avoid pinning the mount.
> +
> +The health monitoring file hooks certain points of the filesystem so that it
> +may receive events about metadata health, filesystem shutdowns, media errors,
> +file I/O errors, and unmounting of the filesystem.
> +Events are queued up for each health monitor file and encoded into a
> +``struct xfs_health_monitor_event`` object when the agent calls ``read()`` on
> +the file.
> +All health events are dispatched to a background threadpool to reduce stalls
> +in the main event loop.
> +Events can be logged into the system log for further analysis.
> +
> +For metadata health events, the specific details are used to construct a call
> +to the scrub ioctl.
> +The filesystem mountpoint is reopened, and the kernel is called.
> +If events are lost or the repairs fail, a full scan will be initiated by
> +starting up an ``xfs_scrub@.service`` for the given mountpoint.
> +
> +A filesystem shutdown causes all future repair work to cease, and an unmount
> +causes the agent to exit.
> +
> +**Question**: Why use a pseudofile and not use existing notification methods?
> +
> +*Answer*: The pseudofile is a private filesystem interface only available to
> +processes with the CAP_SYS_ADMIN priviledge.
> +Being private gives the kernel and ``xfs_healer`` the flexibility to change
> +or update the event format in the future without worrying about backwards
> +compatibility.
> +Using existing notifications means that the event format would be frozen in
> +public UAPI forever.
> +
> +The pseudofile can also accept ioctls, which gives ``xfs_healer`` a solid
> +means to validate that prior to a repair, its reopened mountpoint is actually
> +the same filesystem that is being monitored.
> +
> +**Future Work Question**: Should the healer daemon also register a dbus
> +listener and publish events there?
> +
> +*Answer*: This is unclear -- if there's a demand for system monitoring daemons
> +to consume this information and make decisions, then yes, this could be wired
> +up in ``xfs_healer``.
> +On the other hand, systemd is in the middle of a transition to varlink, so
> +it makes more sense to wait and see what happens.
> +
>  7. Conclusion and Future Work
>  =============================
>  
> 
> 

