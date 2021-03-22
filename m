Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144693439F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 07:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCVGsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 02:48:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVGse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:48:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12M6iwE0127220;
        Mon, 22 Mar 2021 06:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tf+tAt74UwO2N02Ko+BjIW5Ek6bOwoHhS/QUNSqJJqE=;
 b=vy43kz/ohhkQttLXmyPsB6uPeffM/ksvHcnQC7QQmkGNEluAVAHNri+SnknScdWMVwPe
 wWO1NOhdfkLaXGYgV5ACQBN+BvakfVucEefl9UwGbD2pqWLob9hBEdbTQ5mynNMGC/y4
 xQTZT6vpEYcEk+fF+goy+JB2IJeX82B3yKmnKdElQVp5e7lV2hMp5qmWzxRlFkY2R8Ei
 2+usE0l/3649PkMUGtWNg6dFxciC0sicX+/jZCFjCnHusjgkc/rM1/FeDiqrs4nJ7V4Q
 3pXoVrUAStAphx/uJ3LU8R66sOaeEnHm3US1HnYzoCnT0JadQdemzSLqC7pyjwGBV5t0 sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr2fkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 06:47:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12M6k3BK045074;
        Mon, 22 Mar 2021 06:47:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37dttq74pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 06:47:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12M6lQPM001040;
        Mon, 22 Mar 2021 06:47:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Mar 2021 23:47:25 -0700
Date:   Mon, 22 Mar 2021 09:47:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Message-ID: <20210322064712.GD1667@kadam>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-3-namjae.jeon@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=767 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220049
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=712
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220049
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:41PM +0900, Namjae Jeon wrote:
> +static unsigned char
> +asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch)
> +{
> +	if (ctx->pointer >= ctx->end) {
> +		ctx->error = ASN1_ERR_DEC_EMPTY;
> +		return 0;
> +	}
> +	*ch = *(ctx->pointer)++;
> +	return 1;
> +}


Make this bool.

> +
> +static unsigned char
> +asn1_tag_decode(struct asn1_ctx *ctx, unsigned int *tag)
> +{
> +	unsigned char ch;
> +
> +	*tag = 0;
> +
> +	do {
> +		if (!asn1_octet_decode(ctx, &ch))
> +			return 0;
> +		*tag <<= 7;
> +		*tag |= ch & 0x7F;
> +	} while ((ch & 0x80) == 0x80);
> +	return 1;
> +}

Bool.

> +
> +static unsigned char
> +asn1_id_decode(struct asn1_ctx *ctx,
> +	       unsigned int *cls, unsigned int *con, unsigned int *tag)
> +{
> +	unsigned char ch;
> +
> +	if (!asn1_octet_decode(ctx, &ch))
> +		return 0;
> +
> +	*cls = (ch & 0xC0) >> 6;
> +	*con = (ch & 0x20) >> 5;
> +	*tag = (ch & 0x1F);
> +
> +	if (*tag == 0x1F) {
> +		if (!asn1_tag_decode(ctx, tag))
> +			return 0;
> +	}
> +	return 1;
> +}


Same.

> +
> +static unsigned char
> +asn1_length_decode(struct asn1_ctx *ctx, unsigned int *def, unsigned int *len)
> +{
> +	unsigned char ch, cnt;
> +
> +	if (!asn1_octet_decode(ctx, &ch))
> +		return 0;
> +
> +	if (ch == 0x80)
> +		*def = 0;
> +	else {
> +		*def = 1;
> +
> +		if (ch < 0x80)
> +			*len = ch;
> +		else {
> +			cnt = (unsigned char) (ch & 0x7F);
> +			*len = 0;
> +
> +			while (cnt > 0) {
> +				if (!asn1_octet_decode(ctx, &ch))
> +					return 0;
> +				*len <<= 8;
> +				*len |= ch;
> +				cnt--;
> +			}
> +		}
> +	}
> +
> +	/* don't trust len bigger than ctx buffer */
> +	if (*len > ctx->end - ctx->pointer)
> +		return 0;
> +
> +	return 1;
> +}


Same etc for all.

> +
> +static unsigned char
> +asn1_header_decode(struct asn1_ctx *ctx,
> +		   unsigned char **eoc,
> +		   unsigned int *cls, unsigned int *con, unsigned int *tag)
> +{
> +	unsigned int def = 0;
> +	unsigned int len = 0;
> +
> +	if (!asn1_id_decode(ctx, cls, con, tag))
> +		return 0;
> +
> +	if (!asn1_length_decode(ctx, &def, &len))
> +		return 0;
> +
> +	/* primitive shall be definite, indefinite shall be constructed */
> +	if (*con == ASN1_PRI && !def)
> +		return 0;
> +
> +	if (def)
> +		*eoc = ctx->pointer + len;
> +	else
> +		*eoc = NULL;
> +	return 1;
> +}
> +
> +static unsigned char
> +asn1_eoc_decode(struct asn1_ctx *ctx, unsigned char *eoc)
> +{
> +	unsigned char ch;
> +
> +	if (!eoc) {
> +		if (!asn1_octet_decode(ctx, &ch))
> +			return 0;
> +
> +		if (ch != 0x00) {
> +			ctx->error = ASN1_ERR_DEC_EOC_MISMATCH;
> +			return 0;
> +		}
> +
> +		if (!asn1_octet_decode(ctx, &ch))
> +			return 0;
> +
> +		if (ch != 0x00) {
> +			ctx->error = ASN1_ERR_DEC_EOC_MISMATCH;
> +			return 0;
> +		}
> +	} else {
> +		if (ctx->pointer != eoc) {
> +			ctx->error = ASN1_ERR_DEC_LENGTH_MISMATCH;
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +static unsigned char
> +asn1_subid_decode(struct asn1_ctx *ctx, unsigned long *subid)
> +{
> +	unsigned char ch;
> +
> +	*subid = 0;
> +
> +	do {
> +		if (!asn1_octet_decode(ctx, &ch))
> +			return 0;
> +
> +		*subid <<= 7;
> +		*subid |= ch & 0x7F;
> +	} while ((ch & 0x80) == 0x80);
> +	return 1;
> +}
> +
> +static int
> +asn1_oid_decode(struct asn1_ctx *ctx,
> +		unsigned char *eoc, unsigned long **oid, unsigned int *len)
> +{
> +	unsigned long subid;
> +	unsigned int size;
> +	unsigned long *optr;
> +
> +	size = eoc - ctx->pointer + 1;
> +
> +	/* first subid actually encodes first two subids */
> +	if (size < 2 || size > UINT_MAX/sizeof(unsigned long))
> +		return 0;
> +
> +	*oid = kmalloc(size * sizeof(unsigned long), GFP_KERNEL);
> +	if (!*oid)
> +		return 0;
> +
> +	optr = *oid;
> +
> +	if (!asn1_subid_decode(ctx, &subid)) {
> +		kfree(*oid);
> +		*oid = NULL;
> +		return 0;
> +	}
> +
> +	if (subid < 40) {
> +		optr[0] = 0;
> +		optr[1] = subid;
> +	} else if (subid < 80) {
> +		optr[0] = 1;
> +		optr[1] = subid - 40;
> +	} else {
> +		optr[0] = 2;
> +		optr[1] = subid - 80;
> +	}
> +
> +	*len = 2;
> +	optr += 2;
> +
> +	while (ctx->pointer < eoc) {
> +		if (++(*len) > size) {
> +			ctx->error = ASN1_ERR_DEC_BADVALUE;
> +			kfree(*oid);
> +			*oid = NULL;
> +			return 0;
> +		}
> +
> +		if (!asn1_subid_decode(ctx, optr++)) {
> +			kfree(*oid);
> +			*oid = NULL;
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}

Still bool.

> +
> +static int
> +compare_oid(unsigned long *oid1, unsigned int oid1len,
> +	    unsigned long *oid2, unsigned int oid2len)
> +{
> +	unsigned int i;
> +
> +	if (oid1len != oid2len)
> +		return 0;
> +
> +	for (i = 0; i < oid1len; i++) {
> +		if (oid1[i] != oid2[i])
> +			return 0;
> +	}
> +	return 1;
> +}

Call this oid_eq()?


> +
> +/* BB check for endian conversion issues here */
> +
> +int
> +ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
> +		    struct ksmbd_conn *conn)
> +{
> +	struct asn1_ctx ctx;
> +	unsigned char *end;
> +	unsigned char *sequence_end;
> +	unsigned long *oid = NULL;
> +	unsigned int cls, con, tag, oidlen, rc, mechTokenlen;
> +	unsigned int mech_type;
> +
> +	ksmbd_debug(AUTH, "Received SecBlob: length %d\n", length);
> +
> +	asn1_open(&ctx, security_blob, length);
> +
> +	/* GSSAPI header */
> +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> +		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
> +		return 0;
> +	} else if ((cls != ASN1_APL) || (con != ASN1_CON)

No need for else after a return 0;  Surely, checkpatch complains about
|| on the following line and the extra parentheses?

	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
		return false;
	}

	if (cls != ASN1_APL || con != ASN1_CON || tag != ASN1_EOC) {
		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
			    tag);
		return false;
	}

> +		   || (tag != ASN1_EOC)) {
> +		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
> +			tag);
> +		return 0;
> +	}
> +
> +	/* Check for SPNEGO OID -- remember to free obj->oid */
> +	rc = asn1_header_decode(&ctx, &end, &cls, &con, &tag);
> +	if (rc) {

This code confused the me at first.  I've always assumed "rc" stands for
"return code" but asn1_header_decode() doesn't return error codes, it
returns true false.  Alway do failure handling, instead of success
handling.  That way when you're reading the code you can just read the
code indented one tab to see what it does and the code indented two
tabs to see how the error handling works.

Good:

	frob();
	if (fail)
		clean up();
	frob();
	if (fail)
		clean up();

Bad:
	frob();
	if (success)
		frob();
		if (success)
			frob();
			if (success)
				frob();
		else
			fail = 1;
	if (fail)
		clean up();

So this code confused me.  Keep the ordering consistent with cls, con,
and tag.  In fact just write it exactly like the lines before.

	if (!asn1_header_decode(&ctx, &end, &cls, &con, &tag)) {
		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
		return false;
	}

	if (cls != ASN1_UNI || con != ASN1_PRI || tag != ASN1_OJI) {
		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
			    tag);
		return false;
	}

	if (!asn1_oid_decode(&ctx, end, &oid, &oidlen))
		return false;
	if (!oid_equiv()) {
		free();
		return false;
	}

	kfree(oid); <-- I added this

Add a kfree(oid) to the success path to avoid a memory leak.

> +		if ((tag == ASN1_OJI) && (con == ASN1_PRI) &&
> +		    (cls == ASN1_UNI)) {
> +			rc = asn1_oid_decode(&ctx, end, &oid, &oidlen);
> +			if (rc) {
> +				rc = compare_oid(oid, oidlen, SPNEGO_OID,
> +						 SPNEGO_OID_LEN);
> +				kfree(oid);
> +			}
> +		} else
> +			rc = 0;
> +	}
> +
> +	/* SPNEGO OID not present or garbled -- bail out */
> +	if (!rc) {
> +		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
> +		return 0;
> +	}
> +
> +	/* SPNEGO */
> +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> +		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
> +		return 0;
> +	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
> +		   || (tag != ASN1_EOC)) {
> +		ksmbd_debug(AUTH,
> +			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
> +			cls, con, tag, end, *end);
> +		return 0;
> +	}
> +
> +	/* negTokenInit */
> +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> +		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
> +		return 0;
> +	} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
> +		   || (tag != ASN1_SEQ)) {
> +		ksmbd_debug(AUTH,
> +			"cls = %d con = %d tag = %d end = %p (%d) exit 1\n",
> +			cls, con, tag, end, *end);
> +		return 0;
> +	}
> +
> +	/* sequence */
> +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> +		ksmbd_debug(AUTH, "Error decoding 2nd part of negTokenInit\n");
> +		return 0;
> +	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
> +		   || (tag != ASN1_EOC)) {
> +		ksmbd_debug(AUTH,
> +			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
> +			cls, con, tag, end, *end);
> +		return 0;
> +	}
> +
> +	/* sequence of */
> +	if (asn1_header_decode
> +	    (&ctx, &sequence_end, &cls, &con, &tag) == 0) {


I just ran checkpatch.pl on your patch and I see that you actually fixed
all the normal checkpatch.pl warnings.  But I'm used to checkpatch.pl
--strict code because that's the default in net and staging.  This file
has 1249 little things like this where checkpatch would have said to
write it like:

	if (!asn1_header_decode(&ctx, &sequence_end, &cls, &con, &tag)) {

total: 1 errors, 1 warnings, 1249 checks, 24501 lines checked

Once a patch has over a thousand style issues then it's too much for
me to handle.  :P

regards,
dan carpenter

