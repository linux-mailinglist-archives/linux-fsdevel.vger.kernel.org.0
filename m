Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4805738D2B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 03:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhEVBCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 21:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhEVBCE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 21:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BBC561168;
        Sat, 22 May 2021 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621645240;
        bh=Vt3b+UuLc4fbk6qm61FPlwLLACpljFhA18jDpQJQkuI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VEzinzV+bEd+nRAokRmpwvhU/hkcNFYyKbNKZ7fmUxC9CZLSQJUjzYWSS6e3zTq1y
         LA25UEiyWMfhRKSVCZ0F3oWLRpNxAzDXtgwhFeIzl4QfGeORRh7QCPnQxDTLMLz5fd
         79r1o51gZ+AxM53et9RgplrV9LviL76YKCNjNXn2b/I42dYyFv5sNJ+3XvwIMGhEp4
         iNLqQHHRNFNiPa0XF1s1p14w2KXa2dD+x2ChL9ksq0OyT5Ek8bvHpgfRYFXl+yqvD1
         GUXz4Q16e6SHSA1Q/gwIuWoeNkhs9leguzyRu6oCFihBA93liNHzquD3PyImKiFoOP
         cDNGPnZd/NGYw==
Received: by mail-oi1-f170.google.com with SMTP id y76so12109660oia.6;
        Fri, 21 May 2021 18:00:40 -0700 (PDT)
X-Gm-Message-State: AOAM530XzNtZFvlUlziGag1Qi/jtyQUoK0OSJCamSkqCxvEIuxaCwpIN
        K5c5CPmqZ8cdlGX1CcpZEuD5wHwt6ShCRZbuAsk=
X-Google-Smtp-Source: ABdhPJw9nRjszVj6ArisijGAXQ4kHtIP0wIfxVpQWjrc2FwgyI0rzQDeQfoRp3lDKd8WdkKTPhqDV8V0rJledTcKzYk=
X-Received: by 2002:aca:dc84:: with SMTP id t126mr4024373oig.32.1621645239595;
 Fri, 21 May 2021 18:00:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:4443:0:0:0:0:0 with HTTP; Fri, 21 May 2021 18:00:39
 -0700 (PDT)
In-Reply-To: <20210521103150.GB24442@kadam>
References: <20210521062637.31347-1-namjae.jeon@samsung.com>
 <CGME20210521063554epcas1p2b7c2f4766547f7f3deec29f1fc5b7c3f@epcas1p2.samsung.com>
 <20210521062637.31347-5-namjae.jeon@samsung.com> <20210521103150.GB24442@kadam>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 22 May 2021 10:00:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_2EmgPMLuyLWwOah0pi16NZpcq7itkKRHdNG24zA2hgQ@mail.gmail.com>
Message-ID: <CAKYAXd_2EmgPMLuyLWwOah0pi16NZpcq7itkKRHdNG24zA2hgQ@mail.gmail.com>
Subject: Re: [Linux-cifsd-devel] [PATCH v3 04/10] cifsd: add authentication
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>, linux-cifs@vger.kernel.org,
        willy@infradead.org, aurelien.aptel@gmail.com,
        linux-cifsd-devel@lists.sourceforge.net, sandeen@sandeen.net,
        linux-kernel@vger.kernel.org, aaptel@suse.com, hch@infradead.org,
        senozhatsky@chromium.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, linux-fsdevel@vger.kernel.org,
        hch@lst.de, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-05-21 19:31 GMT+09:00, Dan Carpenter <dan.carpenter@oracle.com>:
> Didn't someone complain that we already had enough asn1 code in lib
> and shouldn't add this in the subsystem dir?
Are you talking about oid code in lib? If yes, We have sent the
patch(cifs + updated oid code in lib) to list. If that is applied,
ksmbd will also be able to use it. If anything else is a problem, Let
me know it.
>
> Mostly trivial stuff.  It's still not checkpatch --strict clean.  I only
> noticed the "CHECK: Alignment should match open parenthesis" while
> reviewing so the rest of the warnings are apparently something I don't
> care about.  ;)  The reason why I really like the alignment to be match
> the open parenthesis is because then it doesn't line up with the code.
Okay, CHECK: from checkpatch.pl --strict had some things I couldn't
understand.(I'll ask you a question below.)
>
> Generally, I want the success patch indented one tab and the failure
> path indented two tabs.
Could you please explain more about success path ?
>
>> +	rc = generate_key(sess, signing->label, signing->context, key,
>> +		SMB3_SIGN_KEY_SIZE);
>
> Here the SMB3_SIGN_KEY_SIZE is aligned at two tabs.  It slightly slows
> me down when I see code like that which isn't aligned where I expect it.
> It's the same for if statements and four statements, if you align it
> with the open parenthesis then it's easy to see what is part of the
> condition and what is inside because they are indented differently.
>
> Bad:
> 	if (condition &&
> 		condition2)
> 		frob();
> Good:
> 	if (condition &&
> 	    condition2)
> 		frob();
Okay.In the case of the if statement, I modified to align it, but
there seems to be a part that I am missing. I'll check.
checkpatch.pl --strict alarm warnings from function parameter to align
with open parenthesis. I have always dealt with this as a two tab.
Should I fix this case too?

CHECK: Alignment should match open parenthesis
#1114: FILE: auth.c:1114:
+int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
+		__u8 *pi_hash)

And in the case below, one tab or two tab or need to align with open
parenthesis?

CHECK: Alignment should match open parenthesis
#1066: FILE: auth.c:1066:
+		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
+			SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3encryptionkey);

>
> I noticed a couple error code bugs where we return 1 on failure like in
> ksmbd_auth_ntlmv2().  Some buffer overflows with smb_strtoUTF16() and
> UNICODE_LEN().
Okay, I will fix all of you pointed out below.

Thanks for your review!
>
>
> On Fri, May 21, 2021 at 03:26:31PM +0900, Namjae Jeon wrote:
>> This adds NTLM/NTLMv2/Kerberos authentications and signing/encryption.
>>
>> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
>> Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
>> Signed-off-by: Steve French <stfrench@microsoft.com>
>> ---
>>  fs/cifsd/asn1.c                   |  352 ++++++++
>>  fs/cifsd/asn1.h                   |   29 +
>>  fs/cifsd/auth.c                   | 1344 +++++++++++++++++++++++++++++
>>  fs/cifsd/auth.h                   |   90 ++
>>  fs/cifsd/crypto_ctx.c             |  286 ++++++
>>  fs/cifsd/crypto_ctx.h             |   77 ++
>>  fs/cifsd/ntlmssp.h                |  169 ++++
>>  fs/cifsd/spnego_negtokeninit.asn1 |   43 +
>>  fs/cifsd/spnego_negtokentarg.asn1 |   19 +
>>  9 files changed, 2409 insertions(+)
>>  create mode 100644 fs/cifsd/asn1.c
>>  create mode 100644 fs/cifsd/asn1.h
>>  create mode 100644 fs/cifsd/auth.c
>>  create mode 100644 fs/cifsd/auth.h
>>  create mode 100644 fs/cifsd/crypto_ctx.c
>>  create mode 100644 fs/cifsd/crypto_ctx.h
>>  create mode 100644 fs/cifsd/ntlmssp.h
>>  create mode 100644 fs/cifsd/spnego_negtokeninit.asn1
>>  create mode 100644 fs/cifsd/spnego_negtokentarg.asn1
>>
>> diff --git a/fs/cifsd/asn1.c b/fs/cifsd/asn1.c
>> new file mode 100644
>> index 000000000000..aa6ea855c422
>> --- /dev/null
>> +++ b/fs/cifsd/asn1.c
>> @@ -0,0 +1,352 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * The ASB.1/BER parsing code is derived from ip_nat_snmp_basic.c which
>> was in
>> + * turn derived from the gxsnmp package by Gregory McLean & Jochen
>> Friedrich
>> + *
>> + * Copyright (c) 2000 RP Internet (http://www.rpi.net.au ).
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +#include <linux/oid_registry.h>
>> +
>> +#include "glob.h"
>> +
>> +#include "asn1.h"
>> +#include "connection.h"
>> +#include "auth.h"
>> +#include "spnego_negtokeninit.asn1.h"
>> +#include "spnego_negtokentarg.asn1.h"
>> +
>> +#define SPNEGO_OID_LEN 7
>> +#define NTLMSSP_OID_LEN  10
>> +#define KRB5_OID_LEN  7
>> +#define KRB5U2U_OID_LEN  8
>> +#define MSKRB5_OID_LEN  7
>> +static unsigned long SPNEGO_OID[7] = { 1, 3, 6, 1, 5, 5, 2 };
>> +static unsigned long NTLMSSP_OID[10] = { 1, 3, 6, 1, 4, 1, 311, 2, 2, 10
>> };
>> +static unsigned long KRB5_OID[7] = { 1, 2, 840, 113554, 1, 2, 2 };
>> +static unsigned long KRB5U2U_OID[8] = { 1, 2, 840, 113554, 1, 2, 2, 3 };
>> +static unsigned long MSKRB5_OID[7] = { 1, 2, 840, 48018, 1, 2, 2 };
>> +
>> +static char NTLMSSP_OID_STR[NTLMSSP_OID_LEN] = { 0x2b, 0x06, 0x01, 0x04,
>> 0x01,
>> +	0x82, 0x37, 0x02, 0x02, 0x0a };
>> +
>> +static bool
>> +asn1_subid_decode(const unsigned char **begin, const unsigned char *end,
>> +		unsigned long *subid)
>> +{
>> +	const unsigned char *ptr = *begin;
>> +	unsigned char ch;
>> +
>> +	*subid = 0;
>> +
>> +	do {
>> +		if (ptr >= end)
>> +			return false;
>> +
>> +		ch = *ptr++;
>> +		*subid <<= 7;
>> +		*subid |= ch & 0x7F;
>> +	} while ((ch & 0x80) == 0x80);
>> +
>> +	*begin = ptr;
>> +	return true;
>> +}
>> +
>> +static bool asn1_oid_decode(const unsigned char *value, size_t vlen,
>> +		unsigned long **oid, size_t *oidlen)
>> +{
>> +	const unsigned char *iptr = value, *end = value + vlen;
>> +	unsigned long *optr;
>> +	unsigned long subid;
>> +
>> +	vlen += 1;
>> +	if (vlen < 2 || vlen > UINT_MAX/sizeof(unsigned long))
>> +		return false;
>> +
>> +	*oid = kmalloc(vlen * sizeof(unsigned long), GFP_KERNEL);
>> +	if (!*oid)
>> +		return false;
>> +
>> +	optr = *oid;
>> +
>> +	if (!asn1_subid_decode(&iptr, end, &subid)) {
>> +		kfree(*oid);
>> +		*oid = NULL;
>> +		return false;
>> +	}
>
> Make this goto fail;
>
>> +
>> +	if (subid < 40) {
>> +		optr[0] = 0;
>> +		optr[1] = subid;
>> +	} else if (subid < 80) {
>> +		optr[0] = 1;
>> +		optr[1] = subid - 40;
>> +	} else {
>> +		optr[0] = 2;
>> +		optr[1] = subid - 80;
>> +	}
>> +
>> +	*oidlen = 2;
>> +	optr += 2;
>> +
>> +	while (iptr < end) {
>> +		if (++(*oidlen) > vlen) {
>> +			kfree(*oid);
>> +			*oid = NULL;
>> +			return false;
>
> goto fail;
>
>> +		}
>> +
>> +		if (!asn1_subid_decode(&iptr, end, optr++)) {
>> +			kfree(*oid);
>> +			*oid = NULL;
>> +			return false;
>
> goto fail;
>
>> +		}
>> +	}
>> +	return true;
>
>
> fail:
> 	kfree(*oid);
> 	*oid = NULL;
> 	return false;
>
>> +}
>> +
>> +static bool
>> +oid_eq(unsigned long *oid1, unsigned int oid1len,
>> +		unsigned long *oid2, unsigned int oid2len)
>> +{
>> +	unsigned int i;
>> +
>> +	if (oid1len != oid2len)
>> +		return false;
>> +
>> +	for (i = 0; i < oid1len; i++) {
>> +		if (oid1[i] != oid2[i])
>> +			return false;
>> +	}
>
> 	return memcmp(oid1, oid2, oid1len) == 0;
>
>> +	return true;
>> +}
>> +
>> +int
>> +ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
>> +		struct ksmbd_conn *conn)
>> +{
>> +	return asn1_ber_decoder(&spnego_negtokeninit_decoder, conn,
>> +				security_blob, length);
>> +}
>> +
>> +int
>> +ksmbd_decode_negTokenTarg(unsigned char *security_blob, int length,
>> +		struct ksmbd_conn *conn)
>> +{
>> +	return asn1_ber_decoder(&spnego_negtokentarg_decoder, conn,
>> +				security_blob, length);
>> +}
>> +
>> +static int compute_asn_hdr_len_bytes(int len)
>> +{
>> +	if (len > 0xFFFFFF)
>> +		return 4;
>> +	else if (len > 0xFFFF)
>> +		return 3;
>> +	else if (len > 0xFF)
>> +		return 2;
>> +	else if (len > 0x7F)
>> +		return 1;
>> +	else
>> +		return 0;
>> +}
>> +
>> +static void encode_asn_tag(char *buf,
>> +			   unsigned int *ofs,
>> +			   char tag,
>> +			   char seq,
>> +			   int length)
>> +{
>> +	int i;
>> +	int index = *ofs;
>> +	char hdr_len = compute_asn_hdr_len_bytes(length);
>> +	int len = length + 2 + hdr_len;
>> +
>> +	/* insert tag */
>> +	buf[index++] = tag;
>> +
>> +	if (!hdr_len)
>> +		buf[index++] = len;
>> +	else {
>> +		buf[index++] = 0x80 | hdr_len;
>> +		for (i = hdr_len - 1; i >= 0; i--)
>> +			buf[index++] = (len >> (i * 8)) & 0xFF;
>> +	}
>> +
>> +	/* insert seq */
>> +	len = len - (index - *ofs);
>> +	buf[index++] = seq;
>> +
>> +	if (!hdr_len)
>> +		buf[index++] = len;
>> +	else {
>> +		buf[index++] = 0x80 | hdr_len;
>> +		for (i = hdr_len - 1; i >= 0; i--)
>> +			buf[index++] = (len >> (i * 8)) & 0xFF;
>> +	}
>> +
>> +	*ofs += (index - *ofs);
>> +}
>> +
>> +int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer, u16 *buflen,
>> +		char *ntlm_blob, int ntlm_blob_len)
>> +{
>> +	char *buf;
>> +	unsigned int ofs = 0;
>> +	int neg_result_len = 4 + compute_asn_hdr_len_bytes(1) * 2 + 1;
>> +	int oid_len = 4 + compute_asn_hdr_len_bytes(NTLMSSP_OID_LEN) * 2 +
>> +		NTLMSSP_OID_LEN;
>> +	int ntlmssp_len = 4 + compute_asn_hdr_len_bytes(ntlm_blob_len) * 2 +
>> +		ntlm_blob_len;
>> +	int total_len = 4 + compute_asn_hdr_len_bytes(neg_result_len +
>> +			oid_len + ntlmssp_len) * 2 +
>> +			neg_result_len + oid_len + ntlmssp_len;
>> +
>> +	buf = kmalloc(total_len, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	/* insert main gss header */
>> +	encode_asn_tag(buf, &ofs, 0xa1, 0x30, neg_result_len + oid_len +
>> +			ntlmssp_len);
>> +
>> +	/* insert neg result */
>> +	encode_asn_tag(buf, &ofs, 0xa0, 0x0a, 1);
>> +	buf[ofs++] = 1;
>> +
>> +	/* insert oid */
>> +	encode_asn_tag(buf, &ofs, 0xa1, 0x06, NTLMSSP_OID_LEN);
>> +	memcpy(buf + ofs, NTLMSSP_OID_STR, NTLMSSP_OID_LEN);
>> +	ofs += NTLMSSP_OID_LEN;
>> +
>> +	/* insert response token - ntlmssp blob */
>> +	encode_asn_tag(buf, &ofs, 0xa2, 0x04, ntlm_blob_len);
>> +	memcpy(buf + ofs, ntlm_blob, ntlm_blob_len);
>> +	ofs += ntlm_blob_len;
>> +
>> +	*pbuffer = buf;
>> +	*buflen = total_len;
>> +	return 0;
>> +}
>> +
>> +int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
>> +		int neg_result)
>> +{
>> +	char *buf;
>> +	unsigned int ofs = 0;
>> +	int neg_result_len = 4 + compute_asn_hdr_len_bytes(1) * 2 + 1;
>> +	int total_len = 4 + compute_asn_hdr_len_bytes(neg_result_len) * 2 +
>> +		neg_result_len;
>> +
>> +	buf = kmalloc(total_len, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	/* insert main gss header */
>> +	encode_asn_tag(buf, &ofs, 0xa1, 0x30, neg_result_len);
>> +
>> +	/* insert neg result */
>> +	encode_asn_tag(buf, &ofs, 0xa0, 0x0a, 1);
>> +	if (neg_result)
>> +		buf[ofs++] = 2;
>> +	else
>> +		buf[ofs++] = 0;
>> +
>> +	*pbuffer = buf;
>> +	*buflen = total_len;
>> +	return 0;
>> +}
>> +
>> +int gssapi_this_mech(void *context, size_t hdrlen,
>> +		unsigned char tag, const void *value, size_t vlen)
>> +{
>> +	unsigned long *oid;
>> +	size_t oidlen;
>> +	int err = 0;
>> +
>> +	if (!asn1_oid_decode(value, vlen, &oid, &oidlen)) {
>> +		err = -EBADMSG;
>> +		goto out;
>> +	}
>> +
>> +	if (!oid_eq(oid, oidlen, SPNEGO_OID, SPNEGO_OID_LEN))
>> +		err = -EBADMSG;
>> +	kfree(oid);
>> +out:
>> +	if (err) {
>> +		char buf[50];
>> +
>> +		sprint_oid(value, vlen, buf, sizeof(buf));
>> +		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
>> +	}
>> +	return err;
>> +}
>> +
>> +int neg_token_init_mech_type(void *context, size_t hdrlen,
>> +		unsigned char tag, const void *value, size_t vlen)
>> +{
>> +	struct ksmbd_conn *conn = context;
>> +	unsigned long *oid;
>> +	size_t oidlen;
>> +	int mech_type;
>> +
>> +	if (!asn1_oid_decode(value, vlen, &oid, &oidlen)) {
>> +		char buf[50];
>> +
>> +		sprint_oid(value, vlen, buf, sizeof(buf));
>> +		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
>> +		return -EBADMSG;
>> +	}
>> +
>> +	if (oid_eq(oid, oidlen, NTLMSSP_OID, NTLMSSP_OID_LEN))
>> +		mech_type = KSMBD_AUTH_NTLMSSP;
>> +	else if (oid_eq(oid, oidlen, MSKRB5_OID, MSKRB5_OID_LEN))
>> +		mech_type = KSMBD_AUTH_MSKRB5;
>> +	else if (oid_eq(oid, oidlen, KRB5_OID, KRB5_OID_LEN))
>> +		mech_type = KSMBD_AUTH_KRB5;
>> +	else if (oid_eq(oid, oidlen, KRB5U2U_OID, KRB5U2U_OID_LEN))
>> +		mech_type = KSMBD_AUTH_KRB5U2U;
>> +	else
>> +		goto out;
>
> Should this be an error path?
>
>> +
>> +	conn->auth_mechs |= mech_type;
>> +	if (conn->preferred_auth_mech == 0)
>> +		conn->preferred_auth_mech = mech_type;
>> +
>> +out:
>> +	kfree(oid);
>> +	return 0;
>> +}
>> +
>> +int neg_token_init_mech_token(void *context, size_t hdrlen,
>> +		unsigned char tag, const void *value, size_t vlen)
>> +{
>> +	struct ksmbd_conn *conn = context;
>> +
>> +	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
>> +	if (!conn->mechToken)
>> +		return -ENOMEM;
>> +
>> +	memcpy(conn->mechToken, value, vlen);
>> +	conn->mechToken[vlen] = '\0';
>> +	return 0;
>> +}
>> +
>> +int neg_token_targ_resp_token(void *context, size_t hdrlen,
>> +		unsigned char tag, const void *value, size_t vlen)
>> +{
>> +	struct ksmbd_conn *conn = context;
>> +
>> +	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
>> +	if (!conn->mechToken)
>> +		return -ENOMEM;
>> +
>> +	memcpy(conn->mechToken, value, vlen);
>> +	conn->mechToken[vlen] = '\0';
>> +	return 0;
>> +}
>> diff --git a/fs/cifsd/asn1.h b/fs/cifsd/asn1.h
>> new file mode 100644
>> index 000000000000..ff2692b502d6
>> --- /dev/null
>> +++ b/fs/cifsd/asn1.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * The ASB.1/BER parsing code is derived from ip_nat_snmp_basic.c which
>> was in
>> + * turn derived from the gxsnmp package by Gregory McLean & Jochen
>> Friedrich
>> + *
>> + * Copyright (c) 2000 RP Internet (http://www.rpi.net.au ).
>> + * Copyright (C) 2018 Samsung Electronics Co., Ltd.
>> + */
>> +
>> +#ifndef __ASN1_H__
>> +#define __ASN1_H__
>> +
>> +int ksmbd_decode_negTokenInit(unsigned char *security_blob,
>> +			      int length,
>> +			      struct ksmbd_conn *conn);
>> +
>> +int ksmbd_decode_negTokenTarg(unsigned char *security_blob,
>> +			      int length,
>> +			      struct ksmbd_conn *conn);
>> +
>> +int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer,
>> +				  u16 *buflen,
>> +				  char *ntlm_blob,
>> +				  int ntlm_blob_len);
>> +
>> +int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer,
>> +				   u16 *buflen,
>> +				   int neg_result);
>> +#endif /* __ASN1_H__ */
>> diff --git a/fs/cifsd/auth.c b/fs/cifsd/auth.c
>> new file mode 100644
>> index 000000000000..6b90aac86fcc
>> --- /dev/null
>> +++ b/fs/cifsd/auth.c
>> @@ -0,0 +1,1344 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
>> + *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/fs.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/backing-dev.h>
>> +#include <linux/writeback.h>
>> +#include <linux/uio.h>
>> +#include <linux/xattr.h>
>> +#include <crypto/hash.h>
>> +#include <crypto/aead.h>
>> +#include <linux/random.h>
>> +#include <linux/scatterlist.h>
>> +
>> +#include "auth.h"
>> +#include "glob.h"
>> +
>> +#include <linux/fips.h>
>> +#include <crypto/des.h>
>> +
>> +#include "server.h"
>> +#include "smb_common.h"
>> +#include "connection.h"
>> +#include "mgmt/user_session.h"
>> +#include "mgmt/user_config.h"
>> +#include "crypto_ctx.h"
>> +#include "transport_ipc.h"
>> +#include "buffer_pool.h"
>> +
>> +/*
>> + * Fixed format data defining GSS header and fixed string
>> + * "not_defined_in_RFC4178@please_ignore".
>> + * So sec blob data in neg phase could be generated statically.
>> + */
>> +static char NEGOTIATE_GSS_HEADER[AUTH_GSS_LENGTH] = {
>> +#ifdef CONFIG_SMB_SERVER_KERBEROS5
>> +	0x60, 0x5e, 0x06, 0x06, 0x2b, 0x06, 0x01, 0x05,
>> +	0x05, 0x02, 0xa0, 0x54, 0x30, 0x52, 0xa0, 0x24,
>> +	0x30, 0x22, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
>> +	0xf7, 0x12, 0x01, 0x02, 0x02, 0x06, 0x09, 0x2a,
>> +	0x86, 0x48, 0x82, 0xf7, 0x12, 0x01, 0x02, 0x02,
>> +	0x06, 0x0a, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82,
>> +	0x37, 0x02, 0x02, 0x0a, 0xa3, 0x2a, 0x30, 0x28,
>> +	0xa0, 0x26, 0x1b, 0x24, 0x6e, 0x6f, 0x74, 0x5f,
>> +	0x64, 0x65, 0x66, 0x69, 0x6e, 0x65, 0x64, 0x5f,
>> +	0x69, 0x6e, 0x5f, 0x52, 0x46, 0x43, 0x34, 0x31,
>> +	0x37, 0x38, 0x40, 0x70, 0x6c, 0x65, 0x61, 0x73,
>> +	0x65, 0x5f, 0x69, 0x67, 0x6e, 0x6f, 0x72, 0x65
>> +#else
>> +	0x60, 0x48, 0x06, 0x06, 0x2b, 0x06, 0x01, 0x05,
>> +	0x05, 0x02, 0xa0, 0x3e, 0x30, 0x3c, 0xa0, 0x0e,
>> +	0x30, 0x0c, 0x06, 0x0a, 0x2b, 0x06, 0x01, 0x04,
>> +	0x01, 0x82, 0x37, 0x02, 0x02, 0x0a, 0xa3, 0x2a,
>> +	0x30, 0x28, 0xa0, 0x26, 0x1b, 0x24, 0x6e, 0x6f,
>> +	0x74, 0x5f, 0x64, 0x65, 0x66, 0x69, 0x6e, 0x65,
>> +	0x64, 0x5f, 0x69, 0x6e, 0x5f, 0x52, 0x46, 0x43,
>> +	0x34, 0x31, 0x37, 0x38, 0x40, 0x70, 0x6c, 0x65,
>> +	0x61, 0x73, 0x65, 0x5f, 0x69, 0x67, 0x6e, 0x6f,
>> +	0x72, 0x65
>> +#endif
>> +};
>> +
>> +void ksmbd_copy_gss_neg_header(void *buf)
>> +{
>> +	memcpy(buf, NEGOTIATE_GSS_HEADER, AUTH_GSS_LENGTH);
>> +}
>> +
>> +static void
>> +str_to_key(unsigned char *str, unsigned char *key)
>> +{
>> +	int i;
>> +
>> +	key[0] = str[0] >> 1;
>> +	key[1] = ((str[0] & 0x01) << 6) | (str[1] >> 2);
>> +	key[2] = ((str[1] & 0x03) << 5) | (str[2] >> 3);
>> +	key[3] = ((str[2] & 0x07) << 4) | (str[3] >> 4);
>> +	key[4] = ((str[3] & 0x0F) << 3) | (str[4] >> 5);
>> +	key[5] = ((str[4] & 0x1F) << 2) | (str[5] >> 6);
>> +	key[6] = ((str[5] & 0x3F) << 1) | (str[6] >> 7);
>> +	key[7] = str[6] & 0x7F;
>> +	for (i = 0; i < 8; i++)
>> +		key[i] = (key[i] << 1);
>> +}
>> +
>> +static int
>> +smbhash(unsigned char *out, const unsigned char *in, unsigned char *key)
>> +{
>> +	unsigned char key2[8];
>> +	struct des_ctx ctx;
>> +
>> +	str_to_key(key, key2);
>> +
>> +	if (fips_enabled) {
>> +		ksmbd_debug(AUTH,
>> +			"FIPS compliance enabled: DES not permitted\n");
>> +		return -ENOENT;
>> +	}
>
> Move this check before the str_to_key().
>
>> +
>> +	des_expand_key(&ctx, key2, DES_KEY_SIZE);
>> +	des_encrypt(&ctx, out, in);
>> +	memzero_explicit(&ctx, sizeof(ctx));
>> +	return 0;
>> +}
>> +
>> +static int ksmbd_enc_p24(unsigned char *p21, const unsigned char *c8,
>> unsigned char *p24)
>> +{
>> +	int rc;
>> +
>> +	rc = smbhash(p24, c8, p21);
>> +	if (rc)
>> +		return rc;
>> +	rc = smbhash(p24 + 8, c8, p21 + 7);
>> +	if (rc)
>> +		return rc;
>> +	rc = smbhash(p24 + 16, c8, p21 + 14);
>> +	return rc;
>
> 	return smbhash(p24 + 16, c8, p21 + 14);
>
>> +}
>> +
>> +/* produce a md4 message digest from data of length n bytes */
>> +static int ksmbd_enc_md4(unsigned char *md4_hash, unsigned char
>> *link_str,
>> +		int link_len)
>> +{
>> +	int rc;
>> +	struct ksmbd_crypto_ctx *ctx;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_md4();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "Crypto md4 allocation error\n");
>> +		return -EINVAL;
>
> It feels like "allocation error" is misleading.  Or maybe return
> -ENOMEM?  It's done consistently for all the ksmbd_crypto_ctx_find_
> calls, though...
>
>> +	}
>> +
>> +	rc = crypto_shash_init(CRYPTO_MD4(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not init md4 shash\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_MD4(ctx), link_str, link_len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not update with link_str\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_MD4(ctx), md4_hash);
>> +	if (rc)
>> +		ksmbd_debug(AUTH, "Could not generate md4 hash\n");
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +static int ksmbd_enc_update_sess_key(unsigned char *md5_hash, char
>> *nonce,
>> +		char *server_challenge, int len)
>> +{
>> +	int rc;
>> +	struct ksmbd_crypto_ctx *ctx;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_md5();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "Crypto md5 allocation error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = crypto_shash_init(CRYPTO_MD5(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not init md5 shash\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_MD5(ctx), server_challenge, len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not update with challenge\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_MD5(ctx), nonce, len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not update with nonce\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_MD5(ctx), md5_hash);
>> +	if (rc)
>> +		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +/**
>> + * ksmbd_gen_sess_key() - function to generate session key
>> + * @sess:	session of connection
>> + * @hash:	source hash value to be used for find session key
>> + * @hmac:	source hmac value to be used for finding session key
>> + *
>> + */
>> +static int ksmbd_gen_sess_key(struct ksmbd_session *sess, char *hash,
>> +		char *hmac)
>> +{
>> +	struct ksmbd_crypto_ctx *ctx;
>> +	int rc = -EINVAL;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_hmacmd5();
>> +	if (!ctx)
>> +		goto out;
>> +
>> +	rc = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
>> +				 hash,
>> +				 CIFS_HMAC_MD5_HASH_SIZE);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "hmacmd5 set key fail error %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_init(CRYPTO_HMACMD5(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not init hmacmd5 error %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_HMACMD5(ctx),
>> +				 hmac,
>> +				 SMB2_NTLMV2_SESSKEY_SIZE);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not update with response error %d\n",
>> +			rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_HMACMD5(ctx), sess->sess_key);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not generate hmacmd5 hash error %d\n",
>> +			rc);
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +static int calc_ntlmv2_hash(struct ksmbd_session *sess, char
>> *ntlmv2_hash,
>> +		char *dname)
>> +{
>> +	int ret = -EINVAL, len;
>> +	wchar_t *domain = NULL;
>> +	__le16 *uniname = NULL;
>> +	struct ksmbd_crypto_ctx *ctx;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_hmacmd5();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "can't generate ntlmv2 hash\n");
>> +		goto out;
>> +	}
>> +
>> +	ret = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
>> +				  user_passkey(sess->user),
>> +				  CIFS_ENCPWD_SIZE);
>> +	if (ret) {
>> +		ksmbd_debug(AUTH, "Could not set NT Hash as a key\n");
>> +		goto out;
>> +	}
>> +
>> +	ret = crypto_shash_init(CRYPTO_HMACMD5(ctx));
>> +	if (ret) {
>> +		ksmbd_debug(AUTH, "could not init hmacmd5\n");
>> +		goto out;
>> +	}
>> +
>> +	/* convert user_name to unicode */
>> +	len = strlen(user_name(sess->user));
>> +	uniname = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
>> +	if (!uniname) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	if (len) {
>> +		len = smb_strtoUTF16(uniname, user_name(sess->user), len,
>> +			sess->conn->local_nls);
>> +		UniStrupr(uniname);
>> +	}
>> +
>> +	ret = crypto_shash_update(CRYPTO_HMACMD5(ctx),
>> +				  (char *)uniname,
>> +				  UNICODE_LEN(len));
>
> len = smb_strtoUTF16() modifies len so UNICODE_LEN() multiplies it by
> two and leads to a read overflow.
>
>> +	if (ret) {
>> +		ksmbd_debug(AUTH, "Could not update with user\n");
>> +		goto out;
>> +	}
>> +
>> +	/* Convert domain name or conn name to unicode and uppercase */
>> +	len = strlen(dname);
>> +	domain = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
>> +	if (!domain) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	len = smb_strtoUTF16((__le16 *)domain, dname, len,
>> +			     sess->conn->local_nls);
>> +
>> +	ret = crypto_shash_update(CRYPTO_HMACMD5(ctx),
>> +				  (char *)domain,
>> +				  UNICODE_LEN(len));
>
> The UNICODE_LEN() leads to a buffer overflow.
>
>> +	if (ret) {
>> +		ksmbd_debug(AUTH, "Could not update with domain\n");
>> +		goto out;
>> +	}
>> +
>> +	ret = crypto_shash_final(CRYPTO_HMACMD5(ctx), ntlmv2_hash);
>> +out:
>> +	if (ret)
>> +		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
>
> I think the if (ret) was intended to go before the out: label.
>
>> +	kfree(uniname);
>> +	kfree(domain);
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ksmbd_auth_ntlm() - NTLM authentication handler
>> + * @sess:	session of connection
>> + * @pw_buf:	NTLM challenge response
>> + * @passkey:	user password
>> + *
>> + * Return:	0 on success, error number on error
>> + */
>> +int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf)
>> +{
>> +	int rc;
>> +	unsigned char p21[21];
>> +	char key[CIFS_AUTH_RESP_SIZE];
>> +
>> +	memset(p21, '\0', 21);
>> +	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
>> +	rc = ksmbd_enc_p24(p21, sess->ntlmssp.cryptkey, key);
>> +	if (rc) {
>> +		ksmbd_err("password processing failed\n");
>> +		return rc;
>> +	}
>> +
>> +	ksmbd_enc_md4(sess->sess_key,
>> +			user_passkey(sess->user),
>> +			CIFS_SMB1_SESSKEY_SIZE);
>> +	memcpy(sess->sess_key + CIFS_SMB1_SESSKEY_SIZE, key,
>> +		CIFS_AUTH_RESP_SIZE);
>> +	sess->sequence_number = 1;
>> +
>> +	if (strncmp(pw_buf, key, CIFS_AUTH_RESP_SIZE) != 0) {
>> +		ksmbd_debug(AUTH, "ntlmv1 authentication failed\n");
>> +		rc = -EINVAL;
>
> 		return -EINVAL;
>
>> +	} else {
>> +		ksmbd_debug(AUTH, "ntlmv1 authentication pass\n");
>
> Pull this in one tab.
>
>> +	}
>> +
>> +	return rc;
>
>
> 	return 0;
>
>> +}
>> +
>> +/**
>> + * ksmbd_auth_ntlmv2() - NTLMv2 authentication handler
>> + * @sess:	session of connection
>> + * @ntlmv2:		NTLMv2 challenge response
>> + * @blen:		NTLMv2 blob length
>> + * @domain_name:	domain name
>> + *
>> + * Return:	0 on success, error number on error
>> + */
>> +int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp
>> *ntlmv2,
>> +		int blen, char *domain_name)
>> +{
>> +	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
>> +	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
>> +	struct ksmbd_crypto_ctx *ctx;
>> +	char *construct = NULL;
>> +	int rc = -EINVAL, len;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_hmacmd5();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5 rc %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = calc_ntlmv2_hash(sess, ntlmv2_hash, domain_name);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not get v2 hash rc %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
>> +				 ntlmv2_hash,
>> +				 CIFS_HMAC_MD5_HASH_SIZE);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not set NTLMV2 Hash as a key\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_init(CRYPTO_HMACMD5(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not init hmacmd5\n");
>> +		goto out;
>> +	}
>> +
>> +	len = CIFS_CRYPTO_KEY_SIZE + blen;
>> +	construct = kzalloc(len, GFP_KERNEL);
>> +	if (!construct) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	memcpy(construct, sess->ntlmssp.cryptkey, CIFS_CRYPTO_KEY_SIZE);
>> +	memcpy(construct + CIFS_CRYPTO_KEY_SIZE,
>> +		(char *)(&ntlmv2->blob_signature), blen);
>
> No need for this (char *) cast.
>
>> +
>> +	rc = crypto_shash_update(CRYPTO_HMACMD5(ctx), construct, len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not update with response\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_HMACMD5(ctx), ntlmv2_rsp);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = ksmbd_gen_sess_key(sess, ntlmv2_hash, ntlmv2_rsp);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not generate sess key\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE);
>
> 	if (memcmp() != 0)
> 		rc = -EINVAL;
>
>
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	kfree(construct);
>> +	return rc;
>> +}
>> +
>> +/**
>> + * __ksmbd_auth_ntlmv2() - NTLM2(extended security) authentication
>> handler
>> + * @sess:	session of connection
>> + * @client_nonce:	client nonce from LM response.
>> + * @ntlm_resp:		ntlm response data from client.
>> + *
>> + * Return:	0 on success, error number on error
>> + */
>> +static int __ksmbd_auth_ntlmv2(struct ksmbd_session *sess, char
>> *client_nonce,
>> +		char *ntlm_resp)
>> +{
>> +	char sess_key[CIFS_SMB1_SESSKEY_SIZE] = {0};
>> +	int rc;
>> +	unsigned char p21[21];
>> +	char key[CIFS_AUTH_RESP_SIZE];
>> +
>> +	rc = ksmbd_enc_update_sess_key(sess_key,
>> +				       client_nonce,
>> +				       (char *)sess->ntlmssp.cryptkey, 8);
>> +	if (rc) {
>> +		ksmbd_err("password processing failed\n");
>> +		goto out;
>> +	}
>> +
>> +	memset(p21, '\0', 21);
>> +	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
>> +	rc = ksmbd_enc_p24(p21, sess_key, key);
>> +	if (rc) {
>> +		ksmbd_err("password processing failed\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = memcmp(ntlm_resp, key, CIFS_AUTH_RESP_SIZE);
>
> 	if (memcmp(ntlm_resp, key, CIFS_AUTH_RESP_SIZE) != 0)
> 		rc = -EINVAL;
>
>> +out:
>> +	return rc;
>> +}
>> +
>> +/**
>> + * ksmbd_decode_ntlmssp_auth_blob() - helper function to construct
>> + * authenticate blob
>> + * @authblob:	authenticate blob source pointer
>> + * @usr:	user details
>> + * @sess:	session of connection
>> + *
>> + * Return:	0 on success, error number on error
>> + */
>> +int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message
>> *authblob,
>> +		int blob_len, struct ksmbd_session *sess)
>> +{
>> +	char *domain_name;
>> +	unsigned int lm_off, nt_off;
>> +	unsigned short nt_len;
>> +	int ret;
>> +
>> +	if (blob_len < sizeof(struct authenticate_message)) {
>> +		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
>> +			blob_len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (memcmp(authblob->Signature, "NTLMSSP", 8)) {
>> +		ksmbd_debug(AUTH, "blob signature incorrect %s\n",
>> +				authblob->Signature);
>> +		return -EINVAL;
>> +	}
>> +
>> +	lm_off = le32_to_cpu(authblob->LmChallengeResponse.BufferOffset);
>> +	nt_off = le32_to_cpu(authblob->NtChallengeResponse.BufferOffset);
>> +	nt_len = le16_to_cpu(authblob->NtChallengeResponse.Length);
>> +
>> +	/* process NTLM authentication */
>> +	if (nt_len == CIFS_AUTH_RESP_SIZE) {
>> +		if (le32_to_cpu(authblob->NegotiateFlags) &
>> +		    NTLMSSP_NEGOTIATE_EXTENDED_SEC)
>> +			return __ksmbd_auth_ntlmv2(sess, (char *)authblob +
>> +				lm_off, (char *)authblob + nt_off);
>> +		else
>> +			return ksmbd_auth_ntlm(sess, (char *)authblob +
>> +				nt_off);
>> +	}
>> +
>> +	/* TODO : use domain name that imported from configuration file */
>> +	domain_name = smb_strndup_from_utf16((const char *)authblob +
>> +			le32_to_cpu(authblob->DomainName.BufferOffset),
>> +			le16_to_cpu(authblob->DomainName.Length), true,
>> +			sess->conn->local_nls);
>> +	if (IS_ERR(domain_name))
>> +		return PTR_ERR(domain_name);
>> +
>> +	/* process NTLMv2 authentication */
>> +	ksmbd_debug(AUTH, "decode_ntlmssp_authenticate_blob dname%s\n",
>> +			domain_name);
>> +	ret = ksmbd_auth_ntlmv2(sess,
>> +			(struct ntlmv2_resp *)((char *)authblob + nt_off),
>> +			nt_len - CIFS_ENCPWD_SIZE,
>> +			domain_name);
>> +	kfree(domain_name);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ksmbd_decode_ntlmssp_neg_blob() - helper function to construct
>> + * negotiate blob
>> + * @negblob: negotiate blob source pointer
>> + * @rsp:     response header pointer to be updated
>> + * @sess:    session of connection
>> + *
>> + */
>> +int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
>> +		int blob_len, struct ksmbd_session *sess)
>> +{
>> +	if (blob_len < sizeof(struct negotiate_message)) {
>> +		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
>> +			blob_len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (memcmp(negblob->Signature, "NTLMSSP", 8)) {
>> +		ksmbd_debug(AUTH, "blob signature incorrect %s\n",
>> +				negblob->Signature);
>> +		return -EINVAL;
>> +	}
>> +
>> +	sess->ntlmssp.client_flags = le32_to_cpu(negblob->NegotiateFlags);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ksmbd_build_ntlmssp_challenge_blob() - helper function to construct
>> + * challenge blob
>> + * @chgblob: challenge blob source pointer to initialize
>> + * @rsp:     response header pointer to be updated
>> + * @sess:    session of connection
>> + *
>> + */
>> +unsigned int
>> +ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
>> +		struct ksmbd_session *sess)
>> +{
>> +	struct target_info *tinfo;
>> +	wchar_t *name;
>> +	__u8 *target_name;
>> +	unsigned int len, flags, blob_off, blob_len, type, target_info_len = 0;
>> +	int cflags = sess->ntlmssp.client_flags;
>> +
>> +	memcpy(chgblob->Signature, NTLMSSP_SIGNATURE, 8);
>> +	chgblob->MessageType = NtLmChallenge;
>> +
>> +	flags = NTLMSSP_NEGOTIATE_UNICODE |
>> +		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_TARGET_TYPE_SERVER |
>> +		NTLMSSP_NEGOTIATE_TARGET_INFO;
>> +
>> +	if (cflags & NTLMSSP_NEGOTIATE_SIGN) {
>> +		flags |= NTLMSSP_NEGOTIATE_SIGN;
>> +		flags |= cflags & (NTLMSSP_NEGOTIATE_128 |
>> +			NTLMSSP_NEGOTIATE_56);
>
> 		flags |= cflags & (NTLMSSP_NEGOTIATE_128 |
> 				   NTLMSSP_NEGOTIATE_56);
>
>
>> +	}
>> +
>> +	if (cflags & NTLMSSP_NEGOTIATE_ALWAYS_SIGN)
>> +		flags |= NTLMSSP_NEGOTIATE_ALWAYS_SIGN;
>> +
>> +	if (cflags & NTLMSSP_REQUEST_TARGET)
>> +		flags |= NTLMSSP_REQUEST_TARGET;
>> +
>> +	if (sess->conn->use_spnego &&
>> +	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
>> +		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
>> +
>> +	chgblob->NegotiateFlags = cpu_to_le32(flags);
>> +	len = strlen(ksmbd_netbios_name());
>> +	name = kmalloc(2 + (len * 2), GFP_KERNEL);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	len = smb_strtoUTF16((__le16 *)name, ksmbd_netbios_name(), len,
>> +			sess->conn->local_nls);
>> +	len = UNICODE_LEN(len);
>
> The smb_strtoUTF16() already modifies len so multiplying it by two a
> second time leads to a buffer overflow?
>
>> +
>> +	blob_off = sizeof(struct challenge_message);
>> +	blob_len = blob_off + len;
>> +
>> +	chgblob->TargetName.Length = cpu_to_le16(len);
>> +	chgblob->TargetName.MaximumLength = cpu_to_le16(len);
>> +	chgblob->TargetName.BufferOffset = cpu_to_le32(blob_off);
>> +
>> +	/* Initialize random conn challenge */
>> +	get_random_bytes(sess->ntlmssp.cryptkey, sizeof(__u64));
>> +	memcpy(chgblob->Challenge, sess->ntlmssp.cryptkey,
>> +		CIFS_CRYPTO_KEY_SIZE);
>> +
>> +	/* Add Target Information to security buffer */
>> +	chgblob->TargetInfoArray.BufferOffset = cpu_to_le32(blob_len);
>> +
>> +	target_name = (__u8 *)chgblob + blob_off;
>> +	memcpy(target_name, name, len);
>> +	tinfo = (struct target_info *)(target_name + len);
>> +
>> +	chgblob->TargetInfoArray.Length = 0;
>> +	/* Add target info list for NetBIOS/DNS settings */
>> +	for (type = NTLMSSP_AV_NB_COMPUTER_NAME;
>> +		type <= NTLMSSP_AV_DNS_DOMAIN_NAME; type++) {
>
> 	for (type = NTLMSSP_AV_NB_COMPUTER_NAME;
> 	     type <= NTLMSSP_AV_DNS_DOMAIN_NAME; type++) {
>
>
>> +		tinfo->Type = cpu_to_le16(type);
>> +		tinfo->Length = cpu_to_le16(len);
>> +		memcpy(tinfo->Content, name, len);
>> +		tinfo = (struct target_info *)((char *)tinfo + 4 + len);
>> +		target_info_len += 4 + len;
>> +	}
>> +
>> +	/* Add terminator subblock */
>> +	tinfo->Type = 0;
>> +	tinfo->Length = 0;
>> +	target_info_len += 4;
>> +
>> +	chgblob->TargetInfoArray.Length = cpu_to_le16(target_info_len);
>> +	chgblob->TargetInfoArray.MaximumLength = cpu_to_le16(target_info_len);
>> +	blob_len += target_info_len;
>> +	kfree(name);
>> +	ksmbd_debug(AUTH, "NTLMSSP SecurityBufferLength %d\n", blob_len);
>> +	return blob_len;
>> +}
>> +
>> +#ifdef CONFIG_SMB_SERVER_KERBEROS5
>> +int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
>> +		int in_len, char *out_blob, int *out_len)
>> +{
>> +	struct ksmbd_spnego_authen_response *resp;
>> +	struct ksmbd_user *user = NULL;
>> +	int retval;
>> +
>> +	resp = ksmbd_ipc_spnego_authen_request(in_blob, in_len);
>> +	if (!resp) {
>> +		ksmbd_debug(AUTH, "SPNEGO_AUTHEN_REQUEST failure\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!(resp->login_response.status & KSMBD_USER_FLAG_OK)) {
>> +		ksmbd_debug(AUTH, "krb5 authentication failure\n");
>> +		retval = -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	if (*out_len <= resp->spnego_blob_len) {
>> +		ksmbd_debug(AUTH, "buf len %d, but blob len %d\n",
>> +				*out_len, resp->spnego_blob_len);
>> +		retval = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (resp->session_key_len > sizeof(sess->sess_key)) {
>> +		ksmbd_debug(AUTH, "session key is too long\n");
>> +		retval = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	user = ksmbd_alloc_user(&resp->login_response);
>> +	if (!user) {
>> +		ksmbd_debug(AUTH, "login failure\n");
>> +		retval = -ENOMEM;
>> +		goto out;
>> +	}
>> +	sess->user = user;
>> +
>> +	memcpy(sess->sess_key, resp->payload, resp->session_key_len);
>> +	memcpy(out_blob, resp->payload + resp->session_key_len,
>> +			resp->spnego_blob_len);
>> +	*out_len = resp->spnego_blob_len;
>> +	retval = 0;
>> +out:
>> +	kvfree(resp);
>> +	return retval;
>> +}
>> +#else
>> +int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
>> +		int in_len, char *out_blob, int *out_len)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif
>> +
>> +/**
>> + * ksmbd_sign_smb2_pdu() - function to generate packet signing
>> + * @conn:	connection
>> + * @key:	signing key
>> + * @iov:        buffer iov array
>> + * @n_vec:	number of iovecs
>> + * @sig:	signature value generated for client request packet
>> + *
>> + */
>> +int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec
>> *iov,
>> +		int n_vec, char *sig)
>> +{
>> +	struct ksmbd_crypto_ctx *ctx;
>> +	int rc = -EINVAL;
>> +	int i;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_hmacsha256();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5 rc %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_setkey(CRYPTO_HMACSHA256_TFM(ctx),
>> +				 key,
>> +				 SMB2_NTLMV2_SESSKEY_SIZE);
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = crypto_shash_init(CRYPTO_HMACSHA256(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "hmacsha256 init error %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < n_vec; i++) {
>> +		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx),
>> +					 iov[i].iov_base,
>> +					 iov[i].iov_len);
>> +		if (rc) {
>> +			ksmbd_debug(AUTH, "hmacsha256 update error %d\n", rc);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_HMACSHA256(ctx), sig);
>> +	if (rc)
>> +		ksmbd_debug(AUTH, "hmacsha256 generation error %d\n", rc);
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +/**
>> + * ksmbd_sign_smb3_pdu() - function to generate packet signing
>> + * @conn:	connection
>> + * @key:	signing key
>> + * @iov:        buffer iov array
>> + * @n_vec:	number of iovecs
>> + * @sig:	signature value generated for client request packet
>> + *
>> + */
>> +int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec
>> *iov,
>> +		int n_vec, char *sig)
>> +{
>> +	struct ksmbd_crypto_ctx *ctx;
>> +	int rc = -EINVAL;
>> +	int i;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_cmacaes();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "could not crypto alloc cmac rc %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_setkey(CRYPTO_CMACAES_TFM(ctx),
>> +				 key,
>> +				 SMB2_CMACAES_SIZE);
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = crypto_shash_init(CRYPTO_CMACAES(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "cmaces init error %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < n_vec; i++) {
>> +		rc = crypto_shash_update(CRYPTO_CMACAES(ctx),
>> +					 iov[i].iov_base,
>> +					 iov[i].iov_len);
>> +		if (rc) {
>> +			ksmbd_debug(AUTH, "cmaces update error %d\n", rc);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_CMACAES(ctx), sig);
>> +	if (rc)
>> +		ksmbd_debug(AUTH, "cmaces generation error %d\n", rc);
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +struct derivation {
>> +	struct kvec label;
>> +	struct kvec context;
>> +	bool binding;
>> +};
>> +
>> +static int generate_key(struct ksmbd_session *sess, struct kvec label,
>> +		struct kvec context, __u8 *key, unsigned int key_size)
>> +{
>> +	unsigned char zero = 0x0;
>> +	__u8 i[4] = {0, 0, 0, 1};
>> +	__u8 L128[4] = {0, 0, 0, 128};
>> +	__u8 L256[4] = {0, 0, 1, 0};
>> +	int rc = -EINVAL;
>> +	unsigned char prfhash[SMB2_HMACSHA256_SIZE];
>> +	unsigned char *hashptr = prfhash;
>> +	struct ksmbd_crypto_ctx *ctx;
>> +
>> +	memset(prfhash, 0x0, SMB2_HMACSHA256_SIZE);
>> +	memset(key, 0x0, key_size);
>> +
>> +	ctx = ksmbd_crypto_ctx_find_hmacsha256();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5 rc %d\n", rc);
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	rc = crypto_shash_setkey(CRYPTO_HMACSHA256_TFM(ctx),
>> +				 sess->sess_key,
>> +				 SMB2_NTLMV2_SESSKEY_SIZE);
>> +	if (rc)
>> +		goto smb3signkey_ret;
>> +
>> +	rc = crypto_shash_init(CRYPTO_HMACSHA256(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "hmacsha256 init error %d\n", rc);
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), i, 4);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with n\n");
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx),
>> +				 label.iov_base,
>> +				 label.iov_len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with label\n");
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), &zero, 1);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with zero\n");
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx),
>> +				 context.iov_base,
>> +				 context.iov_len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with context\n");
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
>> +	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
>> +		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L256, 4);
>> +	else
>> +		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L128, 4);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with L\n");
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_HMACSHA256(ctx), hashptr);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not generate hmacmd5 hash error %d\n",
>> +			rc);
>> +		goto smb3signkey_ret;
>> +	}
>> +
>> +	memcpy(key, hashptr, key_size);
>> +
>> +smb3signkey_ret:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +static int generate_smb3signingkey(struct ksmbd_session *sess,
>> +		const struct derivation *signing)
>> +{
>> +	int rc;
>> +	struct channel *chann;
>> +	char *key;
>> +
>> +	chann = lookup_chann_list(sess);
>> +	if (!chann)
>> +		return 0;
>> +
>> +	if (sess->conn->dialect >= SMB30_PROT_ID && signing->binding)
>> +		key = chann->smb3signingkey;
>> +	else
>> +		key = sess->smb3signingkey;
>> +
>> +	rc = generate_key(sess, signing->label, signing->context, key,
>> +		SMB3_SIGN_KEY_SIZE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!(sess->conn->dialect >= SMB30_PROT_ID && signing->binding))
>> +		memcpy(chann->smb3signingkey, key, SMB3_SIGN_KEY_SIZE);
>> +
>> +	ksmbd_debug(AUTH, "dumping generated AES signing keys\n");
>> +	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
>> +	ksmbd_debug(AUTH, "Session Key   %*ph\n",
>> +			SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
>> +	ksmbd_debug(AUTH, "Signing Key   %*ph\n",
>> +			SMB3_SIGN_KEY_SIZE, key);
>> +	return rc;
>
> 	return 0;
>
>> +}
>> +
>> +int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess)
>> +{
>> +	struct derivation d;
>> +
>> +	d.label.iov_base = "SMB2AESCMAC";
>> +	d.label.iov_len = 12;
>> +	d.context.iov_base = "SmbSign";
>> +	d.context.iov_len = 8;
>> +	d.binding = false;
>> +
>> +	return generate_smb3signingkey(sess, &d);
>> +}
>> +
>> +int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess)
>> +{
>> +	struct derivation d;
>> +
>> +	d.label.iov_base = "SMBSigningKey";
>> +	d.label.iov_len = 14;
>> +	d.context.iov_base = sess->Preauth_HashValue;
>> +	d.context.iov_len = 64;
>> +	d.binding = false;
>> +
>> +	return generate_smb3signingkey(sess, &d);
>> +}
>> +
>> +struct derivation_twin {
>> +	struct derivation encryption;
>> +	struct derivation decryption;
>> +};
>> +
>> +static int generate_smb3encryptionkey(struct ksmbd_session *sess,
>> +		const struct derivation_twin *ptwin)
>> +{
>> +	int rc;
>> +
>> +	rc = generate_key(sess, ptwin->encryption.label,
>> +			ptwin->encryption.context, sess->smb3encryptionkey,
>> +			SMB3_ENC_DEC_KEY_SIZE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = generate_key(sess, ptwin->decryption.label,
>> +			ptwin->decryption.context,
>> +			sess->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	ksmbd_debug(AUTH, "dumping generated AES encryption keys\n");
>> +	ksmbd_debug(AUTH, "Cipher type   %d\n", sess->conn->cipher_type);
>> +	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
>> +	ksmbd_debug(AUTH, "Session Key   %*ph\n",
>> +			SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
>> +	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
>> +	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
>> +		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
>> +			SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3encryptionkey);
>> +		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
>> +			SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3decryptionkey);
>> +	} else {
>> +		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
>> +			SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3encryptionkey);
>> +		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
>> +			SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3decryptionkey);
>> +	}
>> +	return rc;
>
> 	return 0;
>
>> +}
>> +
>> +int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess)
>> +{
>> +	struct derivation_twin twin;
>> +	struct derivation *d;
>> +
>> +	d = &twin.encryption;
>> +	d->label.iov_base = "SMB2AESCCM";
>> +	d->label.iov_len = 11;
>> +	d->context.iov_base = "ServerOut";
>> +	d->context.iov_len = 10;
>> +
>> +	d = &twin.decryption;
>> +	d->label.iov_base = "SMB2AESCCM";
>> +	d->label.iov_len = 11;
>> +	d->context.iov_base = "ServerIn ";
>> +	d->context.iov_len = 10;
>> +
>> +	return generate_smb3encryptionkey(sess, &twin);
>> +}
>> +
>> +int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess)
>> +{
>> +	struct derivation_twin twin;
>> +	struct derivation *d;
>> +
>> +	d = &twin.encryption;
>> +	d->label.iov_base = "SMBS2CCipherKey";
>> +	d->label.iov_len = 16;
>> +	d->context.iov_base = sess->Preauth_HashValue;
>> +	d->context.iov_len = 64;
>> +
>> +	d = &twin.decryption;
>> +	d->label.iov_base = "SMBC2SCipherKey";
>> +	d->label.iov_len = 16;
>> +	d->context.iov_base = sess->Preauth_HashValue;
>> +	d->context.iov_len = 64;
>> +
>> +	return generate_smb3encryptionkey(sess, &twin);
>> +}
>> +
>> +int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
>> +		__u8 *pi_hash)
>> +{
>> +	int rc = -1;
>
>
> 	int rc = -EINVAL;
>
>> +	struct smb2_hdr *rcv_hdr = (struct smb2_hdr *)buf;
>> +	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
>> +	int msg_size = be32_to_cpu(rcv_hdr->smb2_buf_length);
>> +	struct ksmbd_crypto_ctx *ctx = NULL;
>> +
>> +	if (conn->preauth_info->Preauth_HashId ==
>> +	    SMB2_PREAUTH_INTEGRITY_SHA512) {
>
> Flip this condition around:
>
> 	if (conn->preauth_info->Preauth_HashId !=
> 	    SMB2_PREAUTH_INTEGRITY_SHA512)
> 		return -EINVAL;
>
>
>> +		ctx = ksmbd_crypto_ctx_find_sha512();
>> +		if (!ctx) {
>> +			ksmbd_debug(AUTH, "could not alloc sha512 rc %d\n", rc);
>> +			goto out;
>> +		}
>
> Pull this code in a tab.
>
>> +	} else {
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_init(CRYPTO_SHA512(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not init shashn");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_SHA512(ctx), pi_hash, 64);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with n\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_SHA512(ctx), all_bytes_msg, msg_size);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with n\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_SHA512(ctx), pi_hash);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not generate hash err : %d\n", rc);
>> +		goto out;
>> +	}
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
>> +		__u8 *pi_hash)
>> +{
>> +	int rc = -1;
>
> int rc = -EINVAL;
>
>> +	struct ksmbd_crypto_ctx *ctx = NULL;
>> +
>> +	ctx = ksmbd_crypto_ctx_find_sha256();
>> +	if (!ctx) {
>> +		ksmbd_debug(AUTH, "could not alloc sha256 rc %d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_init(CRYPTO_SHA256(ctx));
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not init shashn");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_update(CRYPTO_SHA256(ctx), sd_buf, len);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "could not update with n\n");
>> +		goto out;
>> +	}
>> +
>> +	rc = crypto_shash_final(CRYPTO_SHA256(ctx), pi_hash);
>> +	if (rc) {
>> +		ksmbd_debug(AUTH, "Could not generate hash err : %d\n", rc);
>> +		goto out;
>> +	}
>> +out:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> +
>> +static int ksmbd_get_encryption_key(struct ksmbd_conn *conn, __u64
>> ses_id,
>> +		int enc, u8 *key)
>> +{
>> +	struct ksmbd_session *sess;
>> +	u8 *ses_enc_key;
>> +
>> +	sess = ksmbd_session_lookup(conn, ses_id);
>> +	if (!sess)
>> +		return 1;
>
> Please never return 1 on failure...  :/  return -EINVAL;
>
>> +
>> +	ses_enc_key = enc ? sess->smb3encryptionkey :
>> +		sess->smb3decryptionkey;
>> +	memcpy(key, ses_enc_key, SMB3_ENC_DEC_KEY_SIZE);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void smb2_sg_set_buf(struct scatterlist *sg, const void
>> *buf,
>> +		unsigned int buflen)
>> +{
>> +	void *addr;
>> +
>> +	if (is_vmalloc_addr(buf))
>> +		addr = vmalloc_to_page(buf);
>> +	else
>> +		addr = virt_to_page(buf);
>> +	sg_set_page(sg, addr, buflen, offset_in_page(buf));
>> +}
>> +
>> +static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int
>> nvec,
>> +		u8 *sign)
>> +{
>> +	struct scatterlist *sg;
>> +	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
>> +	int i, nr_entries[3] = {0}, total_entries = 0, sg_idx = 0;
>> +
>> +	for (i = 0; i < nvec - 1; i++) {
>
> If "nvec" is zero this loop will corrupt memory until the system
> crashes.
>
>> +		unsigned long kaddr = (unsigned long)iov[i + 1].iov_base;
>> +
>> +		if (is_vmalloc_addr(iov[i + 1].iov_base)) {
>> +			nr_entries[i] = ((kaddr + iov[i + 1].iov_len +
>> +					PAGE_SIZE - 1) >> PAGE_SHIFT) -
>> +				(kaddr >> PAGE_SHIFT);
>> +		} else {
>> +			nr_entries[i]++;
>> +		}
>> +		total_entries += nr_entries[i];
>> +	}
>> +
>> +	/* Add two entries for transform header and signature */
>> +	total_entries += 2;
>> +
>> +	sg = kmalloc_array(total_entries, sizeof(struct scatterlist),
>> GFP_KERNEL);
>> +	if (!sg)
>> +		return NULL;
>> +
>> +	sg_init_table(sg, total_entries);
>> +	smb2_sg_set_buf(&sg[sg_idx++], iov[0].iov_base + 24, assoc_data_len);
>> +	for (i = 0; i < nvec - 1; i++) {
>> +		void *data = iov[i + 1].iov_base;
>> +		int len = iov[i + 1].iov_len;
>> +
>> +		if (is_vmalloc_addr(data)) {
>> +			int j, offset = offset_in_page(data);
>> +
>> +			for (j = 0; j < nr_entries[i]; j++) {
>> +				unsigned int bytes = PAGE_SIZE - offset;
>> +
>> +				if (len <= 0)
>> +					break;
>
> Can "len" really be negative here?  That can't be good at all...
>
>> +
>> +				if (bytes > len)
>> +					bytes = len;
>> +
>> +				sg_set_page(&sg[sg_idx++],
>> +					    vmalloc_to_page(data), bytes,
>> +					    offset_in_page(data));
>> +
>> +				data += bytes;
>> +				len -= bytes;
>> +				offset = 0;
>> +			}
>> +		} else {
>> +			sg_set_page(&sg[sg_idx++], virt_to_page(data), len,
>> +				    offset_in_page(data));
>> +		}
>> +	}
>> +	smb2_sg_set_buf(&sg[sg_idx], sign, SMB2_SIGNATURE_SIZE);
>> +	return sg;
>> +}
>> +
>> +int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
>> +		unsigned int nvec, int enc)
>> +{
>> +	struct smb2_transform_hdr *tr_hdr =
>> +		(struct smb2_transform_hdr *)iov[0].iov_base;
>> +	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
>> +	int rc = 0;
>
> No need.
>
>> +	struct scatterlist *sg;
>> +	u8 sign[SMB2_SIGNATURE_SIZE] = {};
>> +	u8 key[SMB3_ENC_DEC_KEY_SIZE];
>> +	struct aead_request *req;
>> +	char *iv;
>> +	unsigned int iv_len;
>> +	struct crypto_aead *tfm;
>> +	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
>> +	struct ksmbd_crypto_ctx *ctx;
>> +
>> +	rc = ksmbd_get_encryption_key(conn,
>> +				      le64_to_cpu(tr_hdr->SessionId),
>> +				      enc,
>> +				      key);
>> +	if (rc) {
>> +		ksmbd_err("Could not get %scryption key\n", enc ? "en" : "de");
>> +		return 0;
>
> Please add a comment why this is a return 0.
>
>> +	}
>> +
>> +	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
>> +	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
>> +		ctx = ksmbd_crypto_ctx_find_gcm();
>> +	else
>> +		ctx = ksmbd_crypto_ctx_find_ccm();
>> +	if (!ctx) {
>> +		ksmbd_err("crypto alloc failed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
>> +	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
>> +		tfm = CRYPTO_GCM(ctx);
>> +	else
>> +		tfm = CRYPTO_CCM(ctx);
>> +
>> +	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
>> +	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
>> +		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
>> +	else
>> +		rc = crypto_aead_setkey(tfm, key, SMB3_GCM128_CRYPTKEY_SIZE);
>> +	if (rc) {
>> +		ksmbd_err("Failed to set aead key %d\n", rc);
>> +		goto free_ctx;
>> +	}
>> +
>> +	rc = crypto_aead_setauthsize(tfm, SMB2_SIGNATURE_SIZE);
>> +	if (rc) {
>> +		ksmbd_err("Failed to set authsize %d\n", rc);
>> +		goto free_ctx;
>> +	}
>> +
>> +	req = aead_request_alloc(tfm, GFP_KERNEL);
>> +	if (!req) {
>> +		ksmbd_err("Failed to alloc aead request\n");
>> +		rc = -ENOMEM;
>> +		goto free_ctx;
>> +	}
>> +
>> +	if (!enc) {
>> +		memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
>> +		crypt_len += SMB2_SIGNATURE_SIZE;
>> +	}
>> +
>> +	sg = ksmbd_init_sg(iov, nvec, sign);
>> +	if (!sg) {
>> +		ksmbd_err("Failed to init sg\n");
>> +		rc = -ENOMEM;
>> +		goto free_req;
>> +	}
>> +
>> +	iv_len = crypto_aead_ivsize(tfm);
>> +	iv = kzalloc(iv_len, GFP_KERNEL);
>> +	if (!iv) {
>> +		ksmbd_err("Failed to alloc IV\n");
>> +		rc = -ENOMEM;
>> +		goto free_sg;
>> +	}
>> +
>> +	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
>> +	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
>> +		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
>> +	} else {
>> +		iv[0] = 3;
>> +		memcpy(iv + 1, (char *)tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
>> +	}
>> +
>> +	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
>> +	aead_request_set_ad(req, assoc_data_len);
>> +	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
>> +
>> +	if (enc)
>> +		rc = crypto_aead_encrypt(req);
>> +	else
>> +		rc = crypto_aead_decrypt(req);
>> +	if (!rc && enc)
>> +		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
>
> Always do failure handling.  Don't do sucess handling.  Keep the success
> path at indent level one.  Don't make the last function call special.
>
> 	if (enc)
> 		rc = crypto_aead_encrypt(req);
> 	else
> 		rc = crypto_aead_decrypt(req);
> 	if (rc)
> 		goto free_iv;
>
> 	if (enc)
> 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
>
> free_iv:
> 	kfree(iv);
>
>> +
>> +	kfree(iv);
>> +free_sg:
>> +	kfree(sg);
>> +free_req:
>> +	kfree(req);
>> +free_ctx:
>> +	ksmbd_release_crypto_ctx(ctx);
>> +	return rc;
>> +}
>> diff --git a/fs/cifsd/auth.h b/fs/cifsd/auth.h
>> new file mode 100644
>> index 000000000000..6fcfad5e7e1f
>> --- /dev/null
>> +++ b/fs/cifsd/auth.h
>> @@ -0,0 +1,90 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
>> + */
>> +
>> +#ifndef __AUTH_H__
>> +#define __AUTH_H__
>> +
>> +#include "ntlmssp.h"
>> +
>> +#ifdef CONFIG_SMB_SERVER_KERBEROS5
>> +#define AUTH_GSS_LENGTH		96
>> +#define AUTH_GSS_PADDING	0
>> +#else
>> +#define AUTH_GSS_LENGTH		74
>> +#define AUTH_GSS_PADDING	6
>> +#endif
>> +
>> +#define CIFS_HMAC_MD5_HASH_SIZE	(16)
>> +#define CIFS_NTHASH_SIZE	(16)
>> +
>> +/*
>> + * Size of the ntlm client response
>> + */
>> +#define CIFS_AUTH_RESP_SIZE		24
>> +#define CIFS_SMB1_SIGNATURE_SIZE	8
>> +#define CIFS_SMB1_SESSKEY_SIZE		16
>> +
>> +#define KSMBD_AUTH_NTLMSSP	0x0001
>> +#define KSMBD_AUTH_KRB5		0x0002
>> +#define KSMBD_AUTH_MSKRB5	0x0004
>> +#define KSMBD_AUTH_KRB5U2U	0x0008
>> +
>> +struct ksmbd_session;
>> +struct ksmbd_conn;
>> +struct kvec;
>> +
>> +int ksmbd_crypt_message(struct ksmbd_conn *conn,
>> +			struct kvec *iov,
>> +			unsigned int nvec,
>> +			int enc);
>> +
>> +void ksmbd_copy_gss_neg_header(void *buf);
>> +
>> +int ksmbd_auth_ntlm(struct ksmbd_session *sess,
>> +		    char *pw_buf);
>> +
>> +int ksmbd_auth_ntlmv2(struct ksmbd_session *sess,
>> +		      struct ntlmv2_resp *ntlmv2,
>> +		      int blen,
>> +		      char *domain_name);
>> +
>> +int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message
>> *authblob,
>> +				   int blob_len,
>> +				   struct ksmbd_session *sess);
>> +
>> +int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
>> +				  int blob_len,
>> +				  struct ksmbd_session *sess);
>> +
>> +unsigned int
>> +ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
>> +		struct ksmbd_session *sess);
>> +
>> +int ksmbd_krb5_authenticate(struct ksmbd_session *sess,
>> +			char *in_blob, int in_len,
>> +			char *out_blob, int *out_len);
>> +
>> +int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn,
>> +			char *key,
>> +			struct kvec *iov,
>> +			int n_vec,
>> +			char *sig);
>> +int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn,
>> +			char *key,
>> +			struct kvec *iov,
>> +			int n_vec,
>> +			char *sig);
>> +
>> +int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess);
>> +int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess);
>> +int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess);
>> +int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess);
>> +
>> +int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn,
>> +				     char *buf,
>> +				     __u8 *pi_hash);
>> +int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
>> +		__u8 *pi_hash);
>> +#endif
>> diff --git a/fs/cifsd/crypto_ctx.c b/fs/cifsd/crypto_ctx.c
>> new file mode 100644
>> index 000000000000..1830ae1b5ed3
>> --- /dev/null
>> +++ b/fs/cifsd/crypto_ctx.c
>> @@ -0,0 +1,286 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/string.h>
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +#include <linux/wait.h>
>> +#include <linux/sched.h>
>> +
>> +#include "glob.h"
>> +#include "crypto_ctx.h"
>> +#include "buffer_pool.h"
>> +
>> +struct crypto_ctx_list {
>> +	spinlock_t		ctx_lock;
>> +	int			avail_ctx;
>> +	struct list_head	idle_ctx;
>> +	wait_queue_head_t	ctx_wait;
>> +};
>> +
>> +static struct crypto_ctx_list ctx_list;
>> +
>> +static inline void free_aead(struct crypto_aead *aead)
>> +{
>> +	if (aead)
>> +		crypto_free_aead(aead);
>> +}
>> +
>> +static void free_shash(struct shash_desc *shash)
>> +{
>> +	if (shash) {
>> +		crypto_free_shash(shash->tfm);
>> +		kfree(shash);
>> +	}
>> +}
>> +
>> +static struct crypto_aead *alloc_aead(int id)
>> +{
>> +	struct crypto_aead *tfm = NULL;
>> +
>> +	switch (id) {
>> +	case CRYPTO_AEAD_AES_GCM:
>> +		tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
>> +		break;
>> +	case CRYPTO_AEAD_AES_CCM:
>> +		tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
>> +		break;
>> +	default:
>> +		ksmbd_err("Does not support encrypt ahead(id : %d)\n", id);
>> +		return NULL;
>> +	}
>> +
>> +	if (IS_ERR(tfm)) {
>> +		ksmbd_err("Failed to alloc encrypt aead : %ld\n", PTR_ERR(tfm));
>> +		return NULL;
>> +	}
>> +
>> +	return tfm;
>> +}
>> +
>> +static struct shash_desc *alloc_shash_desc(int id)
>> +{
>> +	struct crypto_shash *tfm = NULL;
>> +	struct shash_desc *shash;
>> +
>> +	switch (id) {
>> +	case CRYPTO_SHASH_HMACMD5:
>> +		tfm = crypto_alloc_shash("hmac(md5)", 0, 0);
>> +		break;
>> +	case CRYPTO_SHASH_HMACSHA256:
>> +		tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
>> +		break;
>> +	case CRYPTO_SHASH_CMACAES:
>> +		tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
>> +		break;
>> +	case CRYPTO_SHASH_SHA256:
>> +		tfm = crypto_alloc_shash("sha256", 0, 0);
>> +		break;
>> +	case CRYPTO_SHASH_SHA512:
>> +		tfm = crypto_alloc_shash("sha512", 0, 0);
>> +		break;
>> +	case CRYPTO_SHASH_MD4:
>> +		tfm = crypto_alloc_shash("md4", 0, 0);
>> +		break;
>> +	case CRYPTO_SHASH_MD5:
>> +		tfm = crypto_alloc_shash("md5", 0, 0);
>> +		break;
>
> No default path.
>
>> +	}
>> +
>> +	if (IS_ERR(tfm))
>> +		return NULL;
>> +
>> +	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
>> +			GFP_KERNEL);
>> +	if (!shash)
>> +		crypto_free_shash(tfm);
>> +	else
>> +		shash->tfm = tfm;
>> +	return shash;
>> +}
>> +
>> +static struct ksmbd_crypto_ctx *ctx_alloc(void)
>> +{
>> +	return kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
>> +}
>
> Delete this function.  Call kzalloc() directly.
>
>> +
>> +static void ctx_free(struct ksmbd_crypto_ctx *ctx)
>
> regards,
> dan carpenter
>
>
> _______________________________________________
> Linux-cifsd-devel mailing list
> Linux-cifsd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-cifsd-devel
>
