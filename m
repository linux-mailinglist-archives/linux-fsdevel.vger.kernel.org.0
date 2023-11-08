Return-Path: <linux-fsdevel+bounces-2445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2717E5FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553491C20BE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA74374E4;
	Wed,  8 Nov 2023 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxK0QdW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972A374C9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 21:13:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8A92581
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699477999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zh3RtFxtqR7UWrPVy8hV5bW36Rc8SV6vsBZyrf5I5c=;
	b=MxK0QdW14ZllXx1HkcoRAWIekvrOYp9NxUK8a1iZR4zR58fSIAo84bUCh/OBkHE3phHk+I
	uk3gH9d2Pt6fQsp5MulrnpFRBsf8hfQdvM01TmfnZDlTwt5qtcAnLXuSz1gYJw/Ehjk+Vk
	cOQ5LMBpGN3aRvsx8bA74ceOaygJtRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-zOYRoNxQPu6UPbTEvkGjnQ-1; Wed, 08 Nov 2023 16:13:13 -0500
X-MC-Unique: zOYRoNxQPu6UPbTEvkGjnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E2D0811E88;
	Wed,  8 Nov 2023 21:13:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A00E42166B26;
	Wed,  8 Nov 2023 21:13:12 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 128D9227F9C; Wed,  8 Nov 2023 16:13:12 -0500 (EST)
Date: Wed, 8 Nov 2023 16:13:12 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu,
	stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
Message-ID: <ZUv56DRM/aiBRspd@redhat.com>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <zdor636rec2ni6oxuic3x55khtr4bkcpqazu3xjdhvlbemsylr@pwjyz2qfa4mm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zdor636rec2ni6oxuic3x55khtr4bkcpqazu3xjdhvlbemsylr@pwjyz2qfa4mm>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sat, Oct 21, 2023 at 04:10:21PM +0000, Alyssa Ross wrote:
> On Thu, Oct 05, 2023 at 04:30:30PM -0400, Vivek Goyal wrote:
> > virtiofs filesystem is mounted using a "tag" which is exported by the
> > virtiofs device. virtiofs driver knows about all the available tags but
> > these are not exported to user space.
> >
> > People have asked these tags to be exported to user space. Most recently
> > Lennart Poettering has asked for it as he wants to scan the tags and mount
> > virtiofs automatically in certain cases.
> >
> > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> 
> Hi, I was one of those people. :)

Hi Alyssa,

Aha... Thanks. I was not able to remember who had requested this.

> 
> > This patch exports tags through sysfs. One tag is associated with each
> > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > Actual filesystem tag can be obtained by reading this "tag" file.
> >
> > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > will show up here.
> >
> > /sys/bus/virtio/devices/virtio<N>/tag
> >
> > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > myfs
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Are you still thinking about exposing this in the uevent as well?
> That would be much more convenient for me, because with this approach
> by the time the "remove" uevent arrives, it's no longer possible to
> check what tag was associated with the device — you have to store it
> somewhere when the device appears, so you can look it up again when the
> device is removed.  (Not everybody uses udev.)

Looks like systemd + udev combination can already take care of it. I just
had to specify "StopWhenUnneeded=true" in my systemd .mount unit file. And
that made sure that when device goes away, virtiofs is unmounted and
service is deactivated.

Following is my mount unit file.

$ cat /etc/systemd/system/mnt-virtiofs.mount

[Unit]
Description=Virtiofs mount myfs
DefaultDependencies=no
ConditionPathExists=/mnt/virtiofs
ConditionCapability=CAP_SYS_ADMIN
Before=sysinit.target
StopWhenUnneeded=true 

[Mount]
What=myfs
Where=/mnt/virtiofs
Type=virtiofs

And following is the udev rule I used.

$ cat /etc/udev/rules.d/80-local.rules
SUBSYSTEM=="virtio", DRIVER=="virtiofs", ATTR{tag}=="myfs", TAG+="systemd", ENV{SYSTEMD_WANTS}+="mnt-virtiofs.mount"

And a combination of above two seems to work. virtiofs is automatically
mounted when device is hotplugged and it is unmounted when device is
hot unplugged.

> 
> Regardless,
> 
> Tested-by: Alyssa Ross <hi@alyssa.is>
> 
> … and a review comment below.
> 
> > ---
> >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 5f1be1da92ce..a5b11e18f331 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -107,6 +107,21 @@ static const struct fs_parameter_spec virtio_fs_parameters[] = {
> >  	{}
> >  };
> >
> > +/* Forward Declarations */
> > +static void virtio_fs_stop_all_queues(struct virtio_fs *fs);
> > +
> > +/* sysfs related */
> > +static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
> > +			char *buf)
> > +{
> > +	struct virtio_device *vdev = container_of(dev, struct virtio_device,
> > +						  dev);
> > +	struct virtio_fs *fs = vdev->priv;
> > +
> > +	return sysfs_emit(buf, "%s", fs->tag);
> 
> All of the other files in the device directory end with trailing
> newlines.  Should this one be an exception?

I did not think much about it but you are right that other files seem
to have a newline at the end. I will add one as well.

Thanks
Vivek


