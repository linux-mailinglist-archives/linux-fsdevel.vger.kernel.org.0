Return-Path: <linux-fsdevel+bounces-3432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB67F486C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8A1B2110C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD94AF6A;
	Wed, 22 Nov 2023 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfQB384h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC591CFBF;
	Wed, 22 Nov 2023 14:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE673C433C8;
	Wed, 22 Nov 2023 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700661641;
	bh=CKpWtcakXU6WLfkLUYMnK2MftqPDlyVQofJh5L4ipog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfQB384hXCtGbDq3OEp+k+dC8Y95OtcvnToRFARS3SDWJ6KN61NI6F7znWBpzVRZy
	 blYNyv3BkMn8/fMRiDzO1wyob3LYygCpQVnZmCWxpglAOIy6qZeHz6EWpbcx6oEnOQ
	 ZD1UymrrTktDwQAdyHxQf0fDGf8zTfossoLSeTUZ6pjaVE/PjBDNbDLRKOPWYc+CRb
	 2hKNctjCDvzK9jCLYwIjwa14u6LOKRZpaQ5fRQhowQWJhI4nHVL83nQSoBQmUEpRzJ
	 XLCy/aOL44CWepHZTKNk0rkoBdAVTaeY3706+7M2UJUp/16I81Xi0ZCKrlm+l+vLC9
	 NR+fFXfKYY1/g==
Date: Wed, 22 Nov 2023 15:00:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
	linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	codalist@coda.cs.cmu.edu
Subject: Re: [PATCH v2 0/4] sysctl: Remove sentinel elements from fs dir
Message-ID: <20231122-undifferenziert-weitschuss-a5d8cc56fbd1@brauner>
References: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>

Looks fine,
Acked-by: Christian Brauner <brauner@kernel.org>

