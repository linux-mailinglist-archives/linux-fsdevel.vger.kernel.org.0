Return-Path: <linux-fsdevel+bounces-4845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46AC804A41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF081C20E18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF3DF6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qOb9FyCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B910F;
	Mon,  4 Dec 2023 21:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q4Xwwf+R6mg0IVTeK/i6oqCoh3sFn0GWCi0J13JBtfc=; b=qOb9FyCpYK/4KobvP2uwty+RVC
	aKcs8RCIM1GaB+jEVQmkuGJdy+OoBGLcX1doQi0if7JBzag9665/MK5OtORAivTDbIIcdyUq2OKzV
	Xx9UbaJnUzGeeh5RsPVPgY4YqT0DJlxUw1VN1F2mTNvBjhpShrX42o5RXnUV/cXjSQUrRLToGUZSE
	FmCu84mXqdwf31dZ+O2oxaY3dpe0YxR2cKwZT0rDW7WEmsffmHSRy5nKQqPyOJ72usqptScFFNBh6
	rYGN3D8F7qyjExbcouVqdX/XtjSmjlnWSxIY2bpgheRYBytg9CEj+V1w3MZOcvh3sPXc3Hqk7855F
	MMIPMB3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAOEM-006KRP-0r;
	Tue, 05 Dec 2023 05:44:26 +0000
Date: Mon, 4 Dec 2023 21:44:26 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: j.granados@samsung.com, willy@infradead.org, josh@joshtriplett.org,
	Kees Cook <keescook@chromium.org>,
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
Message-ID: <ZW64um8/nJaxBw5i@bombadil.infradead.org>
References: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
 <20231122-undifferenziert-weitschuss-a5d8cc56fbd1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-undifferenziert-weitschuss-a5d8cc56fbd1@brauner>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Nov 22, 2023 at 03:00:29PM +0100, Christian Brauner wrote:
> Looks fine,
> Acked-by: Christian Brauner <brauner@kernel.org>

Series applied, thanks!

  Luis

