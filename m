Return-Path: <linux-fsdevel+bounces-606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9A7CD99A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F042281C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABD199CE;
	Wed, 18 Oct 2023 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFEF11717;
	Wed, 18 Oct 2023 10:51:31 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F30F9;
	Wed, 18 Oct 2023 03:51:27 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfL5v-1rTTgR3Mkt-00grKp; Wed, 18 Oct 2023 12:51:04 +0200
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RFC PATCH v2 12/14] bpf: Add flag BPF_DEVCG_ACC_MKNOD_UNS for device access
Date: Wed, 18 Oct 2023 12:50:31 +0200
Message-Id: <20231018105033.13669-13-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
References: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jFFIwS4qwpApd71uT5/zzBofJHrQqQbMnQCJHEMIWW1Lqc23Bv6
 CLaXIgZryPTHHNnoyvu1YqBoKOYSFhL+2PrXRkZWBsk2opEc0nVBAFlgDl0hobyxG49s0Ud
 9YG/8xesCxM8FUqNmbqiQ6caI/0dbJYKNpvwSg28bF8XMhCPg66tLPMklXLhksz8jbOX5Be
 XCthwxUiwm541vxbY+hXA==
UI-OutboundReport: notjunk:1;M01:P0:MNEgPA54IMs=;me9EvLyitsl0wTv0UsXt+4LxB3G
 Eh0yoMuL7/IahwR85VE3A2qEg6zChPO0GZuzIR1zs5Jg9SQnajBFHzvj7/g7SVxDbaGwPtDbu
 F7Hh5GIa0i+RmWI2OzLgXPGBCqe1A7h2DTWlvI0zAdlwwinvGaZhoqZ/NaZcM7ktbEvFazgys
 +ivqxBeoHVCwclRyx88ZiwSpRjr7SNnUbuRV/dqHyTy5KHLL7dNamTRD92l9Xvpsu5E1MmTA8
 c9ethuj7kCZbBt3Hso5+dXjLc5K+xJp9sV9uJhSh9jYzP5ZxTSygD/VTo6gjBfUO/QqwHgDiz
 DN2b3nPQ/Ka+xDOyXiogyMb+RiDo5eN28l7YLzEZPZvOIlPKyR1gniVBBmHIN1hGqPnHaSUmq
 b096EXkbEEbEKE+sSxGYr8MAb8Xjc/tEqzIIQ8yAW1iJquYM1rZGrICDCSHwkSblINPpsfULD
 OdI1QFuBmuuSEYvCwaFLYlELH/MEGqntz5GEbi2VrFAQs7RNDTYrKHHwz0V3HECnp0MHGCyla
 iIDYh6MStky1f2Z112vlezC18zvZI7y5xmNfx4rMXFvaPoYgP1J5I4aBxDVhvdBZVUpQ/9WWq
 WCQSyKBPIt7tOt1AM4T9pEtbme68dVzHEj00Wu0WrfYAA9EttXA75nqVYaJNdFdSkaklL6sqq
 OMnVc+K/LfD5LpC5oMG9OB3Jl4ELffgkabBtNhPqXE3IZDE5g0pkAdhiM75yPFDKgXL+KleWt
 IMJuv7bdK+xSGELVf0mabwDYZ+t2hJx2tfHTDauWnBOqCEULvpciMaMv2o/ulUR7MMl/umNkW
 YpMPYmf7O+6hjzc9yOYOXJEHoSp2/IbkkvZhSkf2YDawB4xecEGdSdap2eMAwzEW6v+VOUjNx
 E6VXNm2pv7kGcVsIISJwHqEvFCyj8YoVj7KA=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With this new flag for bpf cgroup device programs, it should be
possible to guard mknod() access in non-initial user namespaces
later on.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0448700890f7..0196b9c72d3e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6927,6 +6927,7 @@ enum {
 	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
 	BPF_DEVCG_ACC_READ	= (1ULL << 1),
 	BPF_DEVCG_ACC_WRITE	= (1ULL << 2),
+	BPF_DEVCG_ACC_MKNOD_UNS	= (1ULL << 3),
 };
 
 enum {
-- 
2.30.2


