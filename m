Return-Path: <linux-fsdevel+bounces-75301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHqdMVaQc2l0xAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:14:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B278377987
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CB7630466D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC92BE7DF;
	Fri, 23 Jan 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="XBhbk3vS";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="VPyvMLoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43859245005
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180800; cv=none; b=maExslmo6hxF5OOyJtYBzpZz3i6KZfvu/5k8AFulqJTVRCN90MIaMvfLt3sKJOAoWDo/WTKVP0au3d7CDLl3VOmaOPbo6qpP9y9h6FhEwblERkHgCMXCeTxsQRSGoJieIFz3tK8VaPfZzLIf/HLvexHZqns9TRBcy3Csb8dnakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180800; c=relaxed/simple;
	bh=vjCLcCM2F3IicS+95q5ad2BGOrb3kOWYWjtQkuAY+fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz6sw/QzbkP99OwS1b1G6OWy9/LtfKwsMTP11PGpMUl0rty8g+R3xub2G0/mnodCjSdmckLUWpcRH+U6iEjoaG99vtN3xq/KAUGuwNaS00iZ2KARVMVCjPxNqvC1ZhorQNfYd5tFuMU1whGr/spOw2IQSQNFvNhDb80t9efT4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=XBhbk3vS reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=VPyvMLoC; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769181699; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=6Y7DdxPq3eM3t0cx86EDuwdGb1aCri5BBH+ThrSGicw=; b=XBhbk3vSBSolOkJgJIx5FW7BoM
	FMt/OpBu5laPQbzdxTxd5koDR4hAPgFMkcMTBItlCQYnUMH3CDJmBjDbfZjIeojsKttHg/lEtPxLL
	0WZUZNRaF2RYHKiR1QXH4KoS0wfm5rCJSSFO+fZ4QumNR6+VYcPC/rTn50XNGvY2bIWYxC2Dc9Ba5
	2hrSVwWs3au3jBcFe6jx1d7w+jfKTGY9vBFjT+JepGzCzF5BV87HItnAfa/h1u8hbVQEjLalSTowJ
	1KkE/+rRZgbiZrrcaVphyDt5gL8Upzz7LhMgZdXDN0mHeUX8UTy7O8RBRxlb+aRDLZhy3hunr0bAD
	UblTHtvw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769180799; h=from : subject
 : to : message-id : date;
 bh=6Y7DdxPq3eM3t0cx86EDuwdGb1aCri5BBH+ThrSGicw=;
 b=VPyvMLoC5tSuHY7qkQlOWcYYofpF9WfwLAx4S0KaVUE179z9Pi6sgAP3WrWEOHKoRDwEB
 sdGRXoTvgLOPReOKH6XEBchn0xlj5OZKQmYpmYHwuaju0A79uqT3mpiOAdLCfzoaRyd07h5
 swI/xFADNTz23qNWayXIszhnoSbF/56G4h+aKdll5q/Ib5Pu2QojyRCG9PB7lYo52djtbTN
 6b9wL18SA0tJMNKWJZiH/ipAJTxCcw6dcIIma+FDfHJSejQ+sLlW83nmrgLlJWF3P9OJCH1
 nApZfCgScgGqsFB19/XVjptniu0UQuTOqlbNHH6wfUfrMwLd61KlGVB3yqjQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjO-TRk3SA-Pq; Fri, 23 Jan 2026 15:05:50 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjO-4o5NDgrkAJF-qZA0; Fri, 23 Jan 2026 15:05:50 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 2/2] 9p: Track 9P RPC waiting time as IO
Date: Fri, 23 Jan 2026 15:48:08 +0100
Message-ID: <b8601271263011203fa34eada2e8ac21d9f679e5.1769179462.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769179462.git.repk@triplefau.lt>
References: <cover.1769179462.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: QUJwr4JLCMmv.fWY_IANUfrLf.4e550wngm10
Feedback-ID: 510616m:510616apGKSTK:510616sagCjD9iGE
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-75301-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[smtpservice.net:s=maxzs0.a1-4.dyn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[smtpservice.net:~,triplefau.lt:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B278377987
X-Rspamd-Action: no action

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c       |  4 ++--
 net/9p/trans_virtio.c | 14 +++++++-------
 net/9p/trans_xen.c    |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index f60d1d041adb..1b475525ac5b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -590,8 +590,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq,
-				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 10c2dd486438..370f4f37dcec 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -284,8 +284,8 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_killable(*chan->vc_wq,
-						  chan->ring_bufs_avail);
+			err = io_wait_event_killable(*chan->vc_wq,
+						     chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				return err;
 
@@ -325,7 +325,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 		 * Other zc request to finish here
 		 */
 		if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
-			err = wait_event_killable(vp_wq,
+			err = io_wait_event_killable(vp_wq,
 			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
 			if (err == -ERESTARTSYS)
 				return err;
@@ -512,8 +512,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_killable(*chan->vc_wq,
-						  chan->ring_bufs_avail);
+			err = io_wait_event_killable(*chan->vc_wq,
+						     chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				goto err_out;
 
@@ -531,8 +531,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	kicked = 1;
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
-	err = wait_event_killable(req->wq,
-			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 	// RERROR needs reply (== error string) in static data
 	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
 	    unlikely(req->rc.sdata[4] == P9_RERROR))
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 12f752a92332..d57965e6aab0 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -136,8 +136,8 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	ring = &priv->rings[num];
 
 again:
-	while (wait_event_killable(ring->wq,
-				   p9_xen_write_todo(ring, size)) != 0)
+	while (io_wait_event_killable(ring->wq,
+				      p9_xen_write_todo(ring, size)) != 0)
 		;
 
 	spin_lock_irqsave(&ring->lock, flags);
-- 
2.50.1


