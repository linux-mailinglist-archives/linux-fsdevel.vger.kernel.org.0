Return-Path: <linux-fsdevel+bounces-69678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B0C80F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE783A80C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10D30F925;
	Mon, 24 Nov 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="VAXvg/Q2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D63074AA;
	Mon, 24 Nov 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994017; cv=none; b=jIs/nGQVgF1xENbS/AQUfHIIqVgOAI/H4BW7xrVxbFg2C/v63RMl1jN2RcJWjO4pxaJRPTlOvFPtQnRSTI0CQfkGDt0RNIXBUfVjuN/3Px+HJYKmn+o52yu3qAbX27rdK1OKw6ibcvYRXm/5rKt95E8ZglyGGyhslNmhkek93jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994017; c=relaxed/simple;
	bh=AdGqZnWIeNvNp603Uj3GiltBeXNjuO+POrVOE8vj6D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCFa8lRH27mWyU2M+Q8kfetymuxLkrbu/bCqIBwnRdKwohvNhGnb/qNEhGcO6N2rE5XsUg+aEaRnFxx6SmxEemEuB/CO+mpgHv10riY6t1oE5NBIyEKfwDlxVWycGbxGE/3Up7w/HsfnuHS2czr2xZJNoxGPTHqlVMMJV+JsU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=VAXvg/Q2; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=xc0xHs8XvGGdTg0jxOqZPG1yY4Hyx1xb5fcdYotTkSc=; b=VAXvg/Q23sq3aDcW0fsye0LvF1
	0ZAuuYEQhAG4mLOXQZp9PM5mEjyliJGCbIKuY9FctrVcCnwUHblC4c5ZALUcEexOkkoFl4Egso2Au
	za6eU8Oou09OC/sFTVhaJR9OEP+9lwWFF7IpAmA3Ltjb+Lld2Pya6HD5lh1Ht78aZ6slwTrIe/ecW
	H34X8f3fviUUwnrFoC3zyk0MDAqVGO1fl25D5CXja7+p23sPV16cIYMKYKTJK6HZY4cuMsIA4vFcN
	LklPF7TSm37rnq4OTiAifD3qgaNvX4Uv5KFIx6jaJrHjtz15S8n14b7KRImdbPjDxQFwnS7/menGK
	iE2ZdOWs2J7pq3sjqHCgNwHoV1mFqe1+jAnqOOfT+TD5j49bc4tj+1FIAOjqVvPpt7hB5IpClfu8u
	7O48l9pk65K0WFOLrjrAI4sc3MQRWfP2UDiRJI044hWElALVzZcL1BviXkTmn5dCObrQ7RsbmtHaD
	acGwcDGJO/cmT+6S1zVRqhHe;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vNXQC-00FPsZ-2z;
	Mon, 24 Nov 2025 14:20:04 +0000
Message-ID: <7b897d50-f637-4f96-ba64-26920e314739@samba.org>
Date: Mon, 24 Nov 2025 15:20:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] cifs: Clean up some places where an extra kvec[]
 was required for rfc1002
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Shyam Prasad N
 <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tom Talpey <tom@talpey.com>
References: <20251124124251.3565566-1-dhowells@redhat.com>
 <20251124124251.3565566-8-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20251124124251.3565566-8-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

I had to squash this into the patch

I'm using smatch when building and got the following error
with this change:

     client/transport.c:1073 compound_send_recv() error: we previously assumed 'resp_iov' could be null (see line 1051)

See my inline comment below to see where the problem is introduced.

It goes away when I squash the following:

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index c023c9873c88..7036acd6542b 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -995,6 +995,9 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
  	if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
  		spin_unlock(&ses->ses_lock);

+		if (WARN_ON_ONCE(num_rqst != 1 || !resp_iov))
+			return -EINVAL;
+
  		cifs_server_lock(server);
  		smb311_update_preauth_hash(ses, server, rqst[0].rq_iov, rqst[0].rq_nvec);
  		cifs_server_unlock(server);


Am 24.11.25 um 13:42 schrieb David Howells:
> Clean up some places where previously an extra element in the kvec array
> was being used to hold an rfc1002 header for SMB1 (a previous patch removed
> this and generated it on the fly as for SMB2/3).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/cifsencrypt.c   | 52 ++++++++---------------------------
>   fs/smb/client/cifsproto.h     |  5 ----
>   fs/smb/client/cifstransport.c | 20 ++------------
>   fs/smb/client/smb1ops.c       | 12 +++++---
>   fs/smb/client/transport.c     | 25 +++++++++--------
>   5 files changed, 35 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
> index 1e0ac87c6686..a9a57904c6b1 100644
> --- a/fs/smb/client/cifsencrypt.c
> +++ b/fs/smb/client/cifsencrypt.c
> @@ -86,26 +86,21 @@ static int cifs_sig_iter(const struct iov_iter *iter, size_t maxsize,
>   int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
>   			  char *signature, struct cifs_calc_sig_ctx *ctx)
>   {
> -	int i;
> +	struct iov_iter iter;
>   	ssize_t rc;
> -	struct kvec *iov = rqst->rq_iov;
> -	int n_vec = rqst->rq_nvec;
> +	size_t size = 0;
>   
> -	for (i = 0; i < n_vec; i++) {
> -		if (iov[i].iov_len == 0)
> -			continue;
> -		if (iov[i].iov_base == NULL) {
> -			cifs_dbg(VFS, "null iovec entry\n");
> -			return -EIO;
> -		}
> +	for (int i = 0; i < rqst->rq_nvec; i++)
> +		size += rqst->rq_iov[i].iov_len;
>   
> -		rc = cifs_sig_update(ctx, iov[i].iov_base, iov[i].iov_len);
> -		if (rc) {
> -			cifs_dbg(VFS, "%s: Could not update with payload\n",
> -				 __func__);
> -			return rc;
> -		}
> -	}
> +	iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, size);
> +
> +	if (iov_iter_count(&iter) <= 4)
> +		return -EIO;
> +
> +	rc = cifs_sig_iter(&iter, iov_iter_count(&iter), ctx);
> +	if (rc < 0)
> +		return rc;
>   
>   	rc = cifs_sig_iter(&rqst->rq_iter, iov_iter_count(&rqst->rq_iter), ctx);
>   	if (rc < 0)
> @@ -186,29 +181,6 @@ int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
>   	return rc;
>   }
>   
> -int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *server,
> -		   __u32 *pexpected_response_sequence)
> -{
> -	struct smb_rqst rqst = { .rq_iov = iov,
> -				 .rq_nvec = n_vec };
> -
> -	return cifs_sign_rqst(&rqst, server, pexpected_response_sequence);
> -}
> -
> -/* must be called with server->srv_mutex held */
> -int cifs_sign_smb(struct smb_hdr *cifs_pdu, unsigned int pdu_len,
> -		  struct TCP_Server_Info *server,
> -		  __u32 *pexpected_response_sequence_number)
> -{
> -	struct kvec iov[1] = {
> -		[0].iov_base = (char *)cifs_pdu,
> -		[0].iov_len = pdu_len,
> -	};
> -
> -	return cifs_sign_smbv(iov, ARRAY_SIZE(iov), server,
> -			      pexpected_response_sequence_number);
> -}
> -
>   int cifs_verify_signature(struct smb_rqst *rqst,
>   			  struct TCP_Server_Info *server,
>   			  __u32 expected_sequence_number)
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index 4af6ea8150c3..39586f2dfad5 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -68,11 +68,6 @@ int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
>   			  char *signature, struct cifs_calc_sig_ctx *ctx);
>   int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
>   		   __u32 *pexpected_response_sequence_number);
> -int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *server,
> -		   __u32 *pexpected_response_sequence);
> -int cifs_sign_smb(struct smb_hdr *cifs_pdu, unsigned int pdu_len,
> -		  struct TCP_Server_Info *server,
> -		  __u32 *pexpected_response_sequence_number);
>   int cifs_verify_signature(struct smb_rqst *rqst,
>   			  struct TCP_Server_Info *server,
>   			  __u32 expected_sequence_number);
> diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
> index 1a0b80fc97d4..6fa60de786e9 100644
> --- a/fs/smb/client/cifstransport.c
> +++ b/fs/smb/client/cifstransport.c
> @@ -71,22 +71,6 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
>   	return smb;
>   }
>   
> -int
> -smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
> -	 unsigned int smb_buf_length)
> -{
> -	struct kvec iov[1] = {
> -		[0].iov_base = smb_buffer,
> -		[0].iov_len = smb_buf_length,
> -	};
> -	struct smb_rqst rqst = {
> -		.rq_iov = iov,
> -		.rq_nvec = ARRAY_SIZE(iov),
> -	};
> -
> -	return __smb_send_rqst(server, 1, &rqst);
> -}
> -
>   static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
>   			struct smb_message **ppmidQ)
>   {
> @@ -370,7 +354,7 @@ int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>   		return rc;
>   	}
>   
> -	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
> +	rc = cifs_sign_rqst(&rqst, server, &smb->sequence_number);
>   	if (rc) {
>   		delete_mid(smb);
>   		cifs_server_unlock(server);
> @@ -378,7 +362,7 @@ int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>   	}
>   
>   	smb->mid_state = MID_REQUEST_SUBMITTED;
> -	rc = smb_send(server, in_buf, in_len);
> +	rc = __smb_send_rqst(server, 1, &rqst);
>   	cifs_save_when_sent(smb);
>   
>   	if (rc < 0)
> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> index 91205685057c..6b0d0b511b9f 100644
> --- a/fs/smb/client/smb1ops.c
> +++ b/fs/smb/client/smb1ops.c
> @@ -34,17 +34,21 @@ static int
>   send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
>   	       struct smb_message *smb)
>   {
> -	int rc = 0;
>   	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
> -	unsigned int in_len = rqst->rq_iov[0].iov_len;
> +	struct kvec iov[1];
> +	struct smb_rqst crqst = { .rq_iov = iov, .rq_nvec = 1 };
> +	int rc = 0;
>   
>   	/* +2 for BCC field */
>   	in_buf->Command = SMB_COM_NT_CANCEL;
>   	in_buf->WordCount = 0;
>   	put_bcc(0, in_buf);
>   
> +	iov[0].iov_base = in_buf;
> +	iov[0].iov_len  = sizeof(struct smb_hdr) + 2;
> +
>   	cifs_server_lock(server);
> -	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
> +	rc = cifs_sign_rqst(&crqst, server, &smb->sequence_number);
>   	if (rc) {
>   		cifs_server_unlock(server);
>   		return rc;
> @@ -56,7 +60,7 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
>   	 * after signing here.
>   	 */
>   	--server->sequence_number;
> -	rc = smb_send(server, in_buf, in_len);
> +	rc = __smb_send_rqst(server, 1, &crqst);
>   	if (rc < 0)
>   		server->sequence_number--;
>   
> diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
> index 2e338e186809..c023c9873c88 100644
> --- a/fs/smb/client/transport.c
> +++ b/fs/smb/client/transport.c
> @@ -1043,22 +1043,23 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>   			goto out;
>   		}
>   
> -		buf = (char *)smb[i]->resp_buf;
> -		resp_iov[i].iov_base = buf;
> -		resp_iov[i].iov_len = smb[i]->resp_buf_size;
> -
> -		if (smb[i]->large_buf)
> -			resp_buf_type[i] = CIFS_LARGE_BUFFER;
> -		else
> -			resp_buf_type[i] = CIFS_SMALL_BUFFER;
> -
>   		rc = server->ops->check_receive(smb[i], server,
>   						     flags & CIFS_LOG_ERROR);
>   
> -		/* mark it so buf will not be freed by delete_mid */
> -		if ((flags & CIFS_NO_RSP_BUF) == 0)
> -			smb[i]->resp_buf = NULL;
> +		if (resp_iov) {

Is it really possible that resp_iov is NULL here?

I guess it is for things with CIFS_NO_RSP_BUF, correct?

> +			buf = (char *)smb[i]->resp_buf;
> +			resp_iov[i].iov_base = buf;
> +			resp_iov[i].iov_len = smb[i]->resp_buf_size;
>   
> +			if (smb[i]->large_buf)
> +				resp_buf_type[i] = CIFS_LARGE_BUFFER;
> +			else
> +				resp_buf_type[i] = CIFS_SMALL_BUFFER;
> +
> +			/* mark it so buf will not be freed by delete_mid */
> +			if ((flags & CIFS_NO_RSP_BUF) == 0)
> +				smb[i]->resp_buf = NULL;
> +		}
>   	}
>   
>   	/*
> 


