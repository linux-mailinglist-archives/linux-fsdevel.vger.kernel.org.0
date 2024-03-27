Return-Path: <linux-fsdevel+bounces-15435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E436C88E6FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF31C2E915
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740191591FB;
	Wed, 27 Mar 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fntl9GJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34613D257;
	Wed, 27 Mar 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546488; cv=none; b=JauUuAQu/M+/408e+aJRISYbM4gG2kN4vMJAehO5KFeYgUg/vImlaFCLxZDMl19G1xh6Q1x/F5ard8LVV5N/509CiqhEIrQ0JgXX7tI5WpAl78i7TpwW7RMw1lqQehsOh4CJ1f+RYmyCRIu7BXRKwVdm2+mJcwa12hVIL+dYsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546488; c=relaxed/simple;
	bh=NZdy0X3liUqTEzRbInNe/vjDY6MNb1re1WUM40McVv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZ8Dln/zjOG72JEUOOS4hbQGPyqejul50l9nbRk1O9/j/Rfqp6RIUUwou18pshvK4NOIXs3J3ok3RAbi8dNC3PJur9gY/y88nXRfR7ArgDBrTakRHToQNEh89L2/kX4IQu3z6HSRuFamam4r/nlwqILxX7Is51TInAIiy4EKT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fntl9GJN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NZdy0X3liUqTEzRbInNe/vjDY6MNb1re1WUM40McVv8=;
	t=1711546486; x=1712756086; b=fntl9GJNw3T27S/XWxW9sEjOSV4SmrZcmhhd4YlmpmHI4Iq
	mnOniwoR0IVjm9aWq+CRox56fWuhkne7MyGhcdaJ/k9N0CamgZPzcOV6zRF/pIndpPcw9Avuee9/t
	Si10y0HmSlsxIerM6wXTBAQ/Rpd4MzPYYamUefqKMbXXytKdsw7G9N4p3a6Sra2uAATsNm1DhnV2I
	/NO/SWUAN3iibTqe88eFukUDg6Zavwqp5anj0M1kJLYbYvKFNJKYt3LTnAYA6SoJQykU8Q/kZ0mAm
	44zBsq7XBJ5QEBZqb6eJqoEbgQY27FyoA4YurKsX7p0fIloHRjrexNCFUtwOY0QQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpTPq-0000000H6pw-3l9Q;
	Wed, 27 Mar 2024 14:34:07 +0100
Message-ID: <46e9539f59c82762e3468a9519fa4123566910d5.camel@sipsolutions.net>
Subject: Re: [PATCH 02/22] um: virt-pci: drop owner assignment
From: Johannes Berg <johannes@sipsolutions.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe
 <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von
 Dentz <luiz.dentz@gmail.com>, Olivia Mackall <olivia@selenic.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, David
 Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan
 Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel
 <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar
 Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,  Stefano Garzarella
 <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Pankaj Gupta
 <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, Miklos
 Szeredi <miklos@szeredi.hu>, Anton Yakovlev
 <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
 nvdimm@lists.linux.dev,  linux-remoteproc@vger.kernel.org,
 linux-scsi@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 alsa-devel@alsa-project.org,  linux-sound@vger.kernel.org
Date: Wed, 27 Mar 2024 14:34:04 +0100
In-Reply-To: <20240327-module-owner-virtio-v1-2-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
	 <20240327-module-owner-virtio-v1-2-0feffab77d99@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 13:40 +0100, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.

> All further patches depend on the first virtio patch, therefore please ac=
k
> and this should go via one tree: virtio?

Sure. Though it's not really actually necessary, you can set it in the
core and merge the other patches in the next cycle; those drivers that
_have_ an .owner aren't broken after all.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

