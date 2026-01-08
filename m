Return-Path: <linux-fsdevel+bounces-72867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F7D04865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CDF32A951B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7663382D4;
	Thu,  8 Jan 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5lKosHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70A3033D0
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885334; cv=none; b=snh5AcWR0qT1Ci9b/OFzMhAJN6htY7fhOdd017mo3P0EdDV2jlGC5NoN7hlWCLu7v5VSNvsroKIQ3RwWQ9awOBXmaU+cJzZpOQq89JeAFU23xCe1+p4I/elz7wd/pLEOX3VpbdksQ5I7ectiz9hmYTGDo02GCjWQDFpuQKGE3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885334; c=relaxed/simple;
	bh=QWFzW8AiryxbX9bHsSDyy6FhwD+iu2OibSf5IcWI1Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eggl/cJoVTY5hE992rX6jpE0I2l45eV8My2IvEGvL175lZ+b4b7076AID7JylDzvJCoSw/p6lGSrprFtyH/Hne87u1FfvVOagvG/CdNoxqZnQIK0n+NAIMnQEErfzulGO5+3FjzY3CJaBpLDy1GUh55GHKl342HKaZobV8g8o/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5lKosHg; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6d13986f8so1642336a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885332; x=1768490132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcFV42Btb4Pg72+ADKdt3ZJAxf5GS4JhHeJgrxvwKog=;
        b=b5lKosHg7+ESgVswffeD5tWTkanPcq3h+ztzV6f/gXXm4nr6yyGM2b09SwLIZENljV
         NrcxpmR1Ev5aLcBPPP549QNjvWH+ocoWnC3eKnq3/Vo0C5oxpa1kbg8ODT55TM+c20BZ
         7ONWTknfNA7bkPfyhwpNnaOPHsKRzCNvOKA2gCt+K3NsmkA3elOWkOkNh7eUvlDBOC7p
         dX0eFSojRFSUXooJMp5DO+aA/6CdBzMHH0GGLpaYnNMFTFvQ8GUcW1oxicBHdzxsYrOD
         eui1PqmUFwlHvbhAgl3dlCBnive1VWuqBIifQT5oC+SpUnjVYTnnnJbVlkJ97Tariz/Q
         bYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885332; x=1768490132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcFV42Btb4Pg72+ADKdt3ZJAxf5GS4JhHeJgrxvwKog=;
        b=CGQKgpiON/OLd5fjWkvW/bvFp37zoaQPoZ5aR0O06KJHdRZwLQMcw7Jd2M3L1udUrA
         Vw9lviVHtW29JZYQK6NHEPz+TyLgFgRTyA4l9D1genrk1H6v5GHHog6M+dn58wbAIbo9
         KULHqlbYF3/3ktLbSnP5LroM86MC7ODfHS3Q4vCOYfTwB9Bf5HYaFQtPpPhj3n/GJaZX
         CGpSrks7pBD+2b7JtcKS5qfp66g9RgbvverK1THQPlBAhiWMzOPZ+SWOqhETxQiK2b22
         cFV5eXe+ZiU59aCysxErLhw8DgwiDsP8tf0Dty8jwnIJrITnRB5IyW5QvVdSy1PHEGqk
         H2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX1KDVF8B9vNmfYqaPZlt8DoVBM+Yt2vAqbUqlJS0nvMpeod5M3XAP1/ZLg0/ok4NPGGN6jcGoMA5Xwq+7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9iTMeu00H2hm+7D47aML8NdtvA3Y38OL8IAE4AWpOksxTAS9
	hEyjaiMdDAmvXLfRIaFXNoEwl3q8paKjMAUtT8gNlIp5yrvP+l2GtA7x
X-Gm-Gg: AY/fxX4XLd7xPUpr37trHHyhYA6ilyqF14IAkR5LFNg4C6XEk0Q1kourgp4LTwFxVIn
	Ecf2pvAWuZwSQFsGPMk0caE8bezo3UfE0vqmJ6o6cpMdvqkm1I1Nyw3PaN+GW6qYZYcjwVP/GrJ
	gNQyZcJw6B5y9p0DecFuuvEn9fp2Y4ew7Q1/4irsu305/5RCUDMuEG20Da0d+VLfbtha6M0GLVL
	PsbNsKYHeg3J3bGLb+MxugcEeWHxgaxj03KZUXLiWnNwZ+0Ds5mQzcPMaFEP4uCL/H1eV4m9/g6
	dgi29yz3ntCsZ9Nq1mB+He6iBSg4/mT5ALSwbJ6hlHiqCrREPMdIZXbD84myq/XhpSvbjx907Yl
	wdN/7xDwJBAdOaQUeAFqLrcHHHfE5R/DJOhc9UgUCYwROM4EFx6H9sxzydbcBA+5TkrF7kYahGH
	3hsbiVuXeLV5NqXR94iHa/R4ncoE6rSQ==
X-Google-Smtp-Source: AGHT+IEwgFQoT6qI08G95oHchDEjjGEhvVdx57kWehu/9O96BbjgHzcPqrjy1Acp6iwhXUgPqgye5Q==
X-Received: by 2002:a9d:4c94:0:b0:7ce:5139:301b with SMTP id 46e09a7af769-7ce5139308emr2469509a34.8.1767885331763;
        Thu, 08 Jan 2026 07:15:31 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c286sm5799755a34.8.2026.01.08.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:15:31 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 09:15:29 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 03/21] dax: Save the kva from memremap
Message-ID: <djiagki7jvoyonnr5ajt43xwasgil6j7sfjhs27gbb6uwckyds@i52ef23dwakh>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-4-john@groves.net>
 <20260108113251.00004f1c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108113251.00004f1c@huawei.com>

On 26/01/08 11:32AM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:12 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Save the kva from memremap because we need it for iomap rw support.
> > 
> > Prior to famfs, there were no iomap users of /dev/dax - so the virtual
> > address from memremap was not needed.
> > 
> > (also fill in missing kerneldoc comment fields for struct dev_dax)
> 
> Do that as a precursor that can be picked up ahead of the rest of the series.

Makes sense. Actually, I'll just send it as a separate standalone patch...

Thanks,
John

[ ... ]



