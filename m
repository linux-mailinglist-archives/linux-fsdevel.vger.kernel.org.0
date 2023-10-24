Return-Path: <linux-fsdevel+bounces-1016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F797D4EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7AD281039
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316F26293;
	Tue, 24 Oct 2023 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoGoCHtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AB26288
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 11:15:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB8FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698146129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSJSEpKk86+44DHG1a6QAaN6xAMr6qX2sKIRljqSTyE=;
	b=VoGoCHtCacLZ5LGL/KK+e1paIE0B+apJndbnGktQSM6d0ILFgJnMIK1crH3NW/mK4kB/st
	pQtntAS4lWNybcix9+P6sUdGkvRdnsqRi8+xM1Tk8IZOix1QFxIG9GaogckESAiiGGNWzN
	21ZqSdQsCovU8V7L8gSE8oPcEMZ9M6A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-N9WQ4euZPqmJjBBin2Iz4Q-1; Tue, 24 Oct 2023 07:15:28 -0400
X-MC-Unique: N9WQ4euZPqmJjBBin2Iz4Q-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c9d4a0ec8aso46941645ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 04:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698146127; x=1698750927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSJSEpKk86+44DHG1a6QAaN6xAMr6qX2sKIRljqSTyE=;
        b=Ubc2VJDBeLyqUTuyse2ZD6q+iilVnT/TZ5Gy6+QtM3lcx0QslUt4deKl/MO0WF/UoQ
         atCPfkoE7TiTh0iDVF381zCFuk2c0787oSJ7B69RDoRUEaC+YDWgzD9yhrNwB31Zxh8B
         /ogEEUnz3oqPJ4bOEyGY8i/Dj79ZLicMFIjrLL7m50ur6O7L79dbFb9kWNhNfkA3ABO0
         hgMtaxG9hR85YkyBxtsdWZyRe5536nGtmIguzLgIKPRd31OzmGtEpn2O5sNH6NSInNLN
         pbKNnXzyWoS5aDqiI9zUNZgizD4pzuJ+633qZqxvZgK7VHVQMDtML9Iw0jCkvMRtYsvK
         AlzA==
X-Gm-Message-State: AOJu0YwJRoO9rCV8qMG2oqHcQDiGzhbr11byo+bSAytzadKLVIAMxsGF
	qu/o7lCVrF7pfdAi9z5hMNV+KbUdtWwqz/1xzapEJeGtWFAAWfbDUdSS3tlMTvKUkaViUKZbIjZ
	hNrObnxDjdOIMtpbl/USuoxeJmuEGlUzKNbYkPu+W5Q==
X-Received: by 2002:a17:903:2286:b0:1bd:da96:dc70 with SMTP id b6-20020a170903228600b001bdda96dc70mr12737212plh.49.1698146126995;
        Tue, 24 Oct 2023 04:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0L75G/Cj63Gt4JTm8S7BbzcPC+Dh8doYG/mYF2FW08Bb0r4vsCFa/ESAfWwBuQapL41pSj1XzYle4AshhNYw=
X-Received: by 2002:a17:903:2286:b0:1bd:da96:dc70 with SMTP id
 b6-20020a170903228600b001bdda96dc70mr12737199plh.49.1698146126743; Tue, 24
 Oct 2023 04:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024075535.2994553-1-amir73il@gmail.com>
In-Reply-To: <20231024075535.2994553-1-amir73il@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 24 Oct 2023 13:15:14 +0200
Message-ID: <CAHc6FU700V+54hU+JPFYNDLkqicG=UPjU81N3UGmgiTSYnz3-g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fs: derive f_fsid from s_uuid
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Amir,

On Tue, Oct 24, 2023 at 9:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> gfs2 already has optional persistent uuid.
>
> Use that uuid to report f_fsid in statfs(2), same as ext2/ext4/zonefs.

I've applied this patch, thank you.

Andreas


