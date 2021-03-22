Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA283452E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 00:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCVXSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 19:18:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34136 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhCVXRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:17:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210322231749epoutp03d1890d57e6750ee242bc3421fc0addcb~uzVJM-aFK1426314263epoutp03a
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 23:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210322231749epoutp03d1890d57e6750ee242bc3421fc0addcb~uzVJM-aFK1426314263epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616455069;
        bh=HJP/hlYecJc1Dh4puplTSM5jofkBNe7SHHG3RGoJzCQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Clt8GUFYOypq1vt6wJGyDe5Ew9JDNkvNvkxht+zqTfxIAQWWj/TvG3SkGKrN1wzeR
         ZVRULABIDoV1x058ISQe7d2VjdFH0ZiVZBpJRry0lxP3Uh64iftdDZM8kiaytUOQlR
         GzOAW7/b6aWDfNnSJ0mtlZBQtTLJ/eEMoTO8pBHs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210322231749epcas1p4eb422103dad7b80da131e53bdb00f0dd~uzVInfVES1682816828epcas1p46;
        Mon, 22 Mar 2021 23:17:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F49QN0Rgrz4x9Pw; Mon, 22 Mar
        2021 23:17:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.70.02418.B9529506; Tue, 23 Mar 2021 08:17:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210322231747epcas1p32706fedff9ecf4a081394f8935fd56f5~uzVHM_pob2118921189epcas1p3q;
        Mon, 22 Mar 2021 23:17:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210322231747epsmtrp26a7cfe06b94da24523103a1d2a82e8f4~uzVHMAbNm2477824778epsmtrp24;
        Mon, 22 Mar 2021 23:17:47 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-5b-6059259bfe4f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.5B.08745.B9529506; Tue, 23 Mar 2021 08:17:47 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210322231747epsmtip277c9b6f13863ab49cb6c33c3065f7156~uzVG2lbk51152211522epsmtip2U;
        Mon, 22 Mar 2021 23:17:47 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>, <smfrench@gmail.com>,
        <senozhatsky@chromium.org>, <hyc.lee@gmail.com>,
        <viro@zeniv.linux.org.uk>, <hch@lst.de>, <hch@infradead.org>,
        <ronniesahlberg@gmail.com>, <aurelien.aptel@gmail.com>,
        <aaptel@suse.com>, <sandeen@sandeen.net>,
        <colin.king@canonical.com>, <rdunlap@infradead.org>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>
In-Reply-To: <20210322064712.GD1667@kadam>
Subject: RE: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Date:   Tue, 23 Mar 2021 08:17:47 +0900
Message-ID: <009b01d71f71$9224f4e0$b66edea0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKnGOaYF8FWW41Vo1OapoCvoUV0QJx6VhoAkDjIaQCMP/z3arxks4g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJsWRmVeSWpSXmKPExsWy7bCmru5s1cgEg5dnrS0a355msTj++i+7
        xe/VvWwWr/9NZ7E4PWERk8XK1UeZLK7df89u8eL/LmaLn/+/M1rs2XuSxeLyrjlsFm/vANX1
        9n1itWi9omWxe+MiNou1nx+zW7x5cZjN4tbE+WwW5/8eZ3UQ9pjV0MvmMbvhIovHzll32T02
        r9Dy2L3gM5PH7psNbB6tO/6ye3x8eovFY8vih0we67dcZfH4vEnOY9OTt0wBPFE5NhmpiSmp
        RQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAPyoplCXmlAKFAhKL
        i5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3IyLvzYyFbQ
        G1YxYeN59gbG/bZdjJwcEgImErd/HGDsYuTiEBLYwSjR9L6bFcL5xCix9sRMqMxnRolF/XOY
        YFqubG9jgUjsYpS4dXUOVNVLRokrvV3sIFVsAroS//7sZwOxRQQMJO6dfMECYjMLzGCReDmN
        D8TmFNCSmHTpHlAzB4ewgLPExq0yIGEWAVWJvXOvgo3hFbCUuLhvKQuELShxcuYTqDHyEtvf
        zmGGOEhB4ufTZawQq9wkti2+CFUjIjG7s40Z5DYJgfmcEhca7zJCNLhInH4wBeobYYlXx7ew
        Q9hSEp/f7WUDuUdCoFri436o+R2MEi++Q8PLWOLm+g2sICXMApoS63fpQ4QVJXb+nssIsZZP
        4t3XHlaIKbwSHW1CECWqEn2XDkMtlZboav/APoFRaRaSx2YheWwWkgdmISxbwMiyilEstaA4
        Nz212LDAEDmuNzGCk7+W6Q7GiW8/6B1iZOJgPMQowcGsJMLbEh6RIMSbklhZlVqUH19UmpNa
        fIjRFBjUE5mlRJPzgfknryTe0NTI2NjYwsTM3MzUWEmcN8ngQbyQQHpiSWp2ampBahFMHxMH
        p1QDU7xlWFN6cdg59WkKQaE8V6u/rSy6nfZfWu+W781p61PXc9yZa3Niy/cs1Ul9ipO3z2C+
        nWEx7XKsaMGPq5c03I5YHn4YbmtT0/N4/90rTOx9MnpLGbsnyk9v4lnMoT83J/xNYVTDUs3m
        nD9xJ73cD/+e7ySiNf342Y/psbGrGwOt1kwz36H8wdZ5BVPAVy9ZkejnH8P6L80qkTaqmByY
        sdTcfjef+PzlbwqNBViXbAImzWmL/mnesd3xxYj3w1rOe0eOdlw5cKzYhHXrlWDf5Ux8Z41f
        qglk3JXrD4r3Yfj2e+qfzW6VnvuYNFtf294Ta3OU7c+8ULTyUlWOUIj/8UqlbbfOt9ZO0fi7
        hENPiaU4I9FQi7moOBEADjUYxocEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSvO5s1cgEg741QhaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2i7d3gOp6
        +z6xWrRe0bLYvXERm8Xaz4/ZLd68OMxmcWvifDaL83+PszoIe8xq6GXzmN1wkcVj56y77B6b
        V2h57F7wmclj980GNo/WHX/ZPT4+vcXisWXxQyaP9Vuusnh83iTnsenJW6YAnigum5TUnMyy
        1CJ9uwSujAs/NrIV9IZVTNh4nr2Bcb9tFyMnh4SAicSV7W0sXYxcHEICOxglehvfsUEkpCWO
        nTjD3MXIAWQLSxw+XAxR85xRomPyTEaQGjYBXYl/f/aD1YsIGEjcO/mCBcRmFljDInFhmzpE
        w21Gif7lHewgCU4BLYlJl+4xggwVFnCW2LhVBiTMIqAqsXfuVbASXgFLiYv7lrJA2IISJ2c+
        YQEpZxbQk2jbyAgxXl5i+9s5zBBnKkj8fLqMFeIEN4ltiy9CnSAiMbuzjXkCo/AsJJNmIUya
        hWTSLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBKcALa0djHtWfdA7xMjE
        wXiIUYKDWUmEtyU8IkGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUw
        WSYOTqkGJp1cg4SJaUnV+Z/sM4UvH9OOLDhtEV8qYPg8yfJaiotsTS6T345davLXl15fUFtv
        dMVB2mb5Or5HT3dG/A/i2hb8pa1OYu2MWbK9ho/tVH8u0dKf1bsoU/Duxkb7ZKa+HRN/WH08
        +vbfJZ2U9r/5Lv+u2s/mn32gMv7YHsHNN34or7SO62BLvl9/Xypu0j6GP6+epBxkPDzpz8VL
        +Te6p0zsZntZ+feYZphg47m8XXei1VclbG6JeXqvtK3NZ+snp8rj9pfS1z1bW8oWVB1cfdZg
        CvsMvgSu/uxr8lfMvpx78r5s2Tr5AC1l1+/fpD/uU5EsfNshYPolWTjmaOMnDQfVyb7qwd0M
        bjMnPrm/VomlOCPRUIu5qDgRALdMdCFwAwAA
X-CMS-MailID: 20210322231747epcas1p32706fedff9ecf4a081394f8935fd56f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052206epcas1p438f15851216f07540537c5547a0a2c02
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
        <20210322051344.1706-3-namjae.jeon@samsung.com>
        <20210322064712.GD1667@kadam>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Mon, Mar 22, 2021 at 02:13:41PM +0900, Namjae Jeon wrote:
> > +static unsigned char
> > +asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch) {
> > +	if (ctx->pointer >= ctx->end) {
> > +		ctx->error = ASN1_ERR_DEC_EMPTY;
> > +		return 0;
> > +	}
> > +	*ch = *(ctx->pointer)++;
> > +	return 1;
> > +}
> 
> 
> Make this bool.
Okay.
> 
> > +
> > +static unsigned char
> > +asn1_tag_decode(struct asn1_ctx *ctx, unsigned int *tag) {
> > +	unsigned char ch;
> > +
> > +	*tag = 0;
> > +
> > +	do {
> > +		if (!asn1_octet_decode(ctx, &ch))
> > +			return 0;
> > +		*tag <<= 7;
> > +		*tag |= ch & 0x7F;
> > +	} while ((ch & 0x80) == 0x80);
> > +	return 1;
> > +}
> 
> Bool.
Okay.
> 
> > +
> > +static unsigned char
> > +asn1_id_decode(struct asn1_ctx *ctx,
> > +	       unsigned int *cls, unsigned int *con, unsigned int *tag) {
> > +	unsigned char ch;
> > +
> > +	if (!asn1_octet_decode(ctx, &ch))
> > +		return 0;
> > +
> > +	*cls = (ch & 0xC0) >> 6;
> > +	*con = (ch & 0x20) >> 5;
> > +	*tag = (ch & 0x1F);
> > +
> > +	if (*tag == 0x1F) {
> > +		if (!asn1_tag_decode(ctx, tag))
> > +			return 0;
> > +	}
> > +	return 1;
> > +}
> 
> 
> Same.
Okay.
> 
> > +
> > +static unsigned char
> > +asn1_length_decode(struct asn1_ctx *ctx, unsigned int *def, unsigned
> > +int *len) {
> > +	unsigned char ch, cnt;
> > +
> > +	if (!asn1_octet_decode(ctx, &ch))
> > +		return 0;
> > +
> > +	if (ch == 0x80)
> > +		*def = 0;
> > +	else {
> > +		*def = 1;
> > +
> > +		if (ch < 0x80)
> > +			*len = ch;
> > +		else {
> > +			cnt = (unsigned char) (ch & 0x7F);
> > +			*len = 0;
> > +
> > +			while (cnt > 0) {
> > +				if (!asn1_octet_decode(ctx, &ch))
> > +					return 0;
> > +				*len <<= 8;
> > +				*len |= ch;
> > +				cnt--;
> > +			}
> > +		}
> > +	}
> > +
> > +	/* don't trust len bigger than ctx buffer */
> > +	if (*len > ctx->end - ctx->pointer)
> > +		return 0;
> > +
> > +	return 1;
> > +}
> 
> 
> Same etc for all.
Okay.
> 
> > +
> > +static unsigned char
> > +asn1_header_decode(struct asn1_ctx *ctx,
> > +		   unsigned char **eoc,
> > +		   unsigned int *cls, unsigned int *con, unsigned int *tag) {
> > +	unsigned int def = 0;
> > +	unsigned int len = 0;
> > +
> > +	if (!asn1_id_decode(ctx, cls, con, tag))
> > +		return 0;
> > +
> > +	if (!asn1_length_decode(ctx, &def, &len))
> > +		return 0;
> > +
> > +	/* primitive shall be definite, indefinite shall be constructed */
> > +	if (*con == ASN1_PRI && !def)
> > +		return 0;
> > +
> > +	if (def)
> > +		*eoc = ctx->pointer + len;
> > +	else
> > +		*eoc = NULL;
> > +	return 1;
> > +}
> > +
> > +static unsigned char
> > +asn1_eoc_decode(struct asn1_ctx *ctx, unsigned char *eoc) {
> > +	unsigned char ch;
> > +
> > +	if (!eoc) {
> > +		if (!asn1_octet_decode(ctx, &ch))
> > +			return 0;
> > +
> > +		if (ch != 0x00) {
> > +			ctx->error = ASN1_ERR_DEC_EOC_MISMATCH;
> > +			return 0;
> > +		}
> > +
> > +		if (!asn1_octet_decode(ctx, &ch))
> > +			return 0;
> > +
> > +		if (ch != 0x00) {
> > +			ctx->error = ASN1_ERR_DEC_EOC_MISMATCH;
> > +			return 0;
> > +		}
> > +	} else {
> > +		if (ctx->pointer != eoc) {
> > +			ctx->error = ASN1_ERR_DEC_LENGTH_MISMATCH;
> > +			return 0;
> > +		}
> > +	}
> > +	return 1;
> > +}
> > +
> > +static unsigned char
> > +asn1_subid_decode(struct asn1_ctx *ctx, unsigned long *subid) {
> > +	unsigned char ch;
> > +
> > +	*subid = 0;
> > +
> > +	do {
> > +		if (!asn1_octet_decode(ctx, &ch))
> > +			return 0;
> > +
> > +		*subid <<= 7;
> > +		*subid |= ch & 0x7F;
> > +	} while ((ch & 0x80) == 0x80);
> > +	return 1;
> > +}
> > +
> > +static int
> > +asn1_oid_decode(struct asn1_ctx *ctx,
> > +		unsigned char *eoc, unsigned long **oid, unsigned int *len) {
> > +	unsigned long subid;
> > +	unsigned int size;
> > +	unsigned long *optr;
> > +
> > +	size = eoc - ctx->pointer + 1;
> > +
> > +	/* first subid actually encodes first two subids */
> > +	if (size < 2 || size > UINT_MAX/sizeof(unsigned long))
> > +		return 0;
> > +
> > +	*oid = kmalloc(size * sizeof(unsigned long), GFP_KERNEL);
> > +	if (!*oid)
> > +		return 0;
> > +
> > +	optr = *oid;
> > +
> > +	if (!asn1_subid_decode(ctx, &subid)) {
> > +		kfree(*oid);
> > +		*oid = NULL;
> > +		return 0;
> > +	}
> > +
> > +	if (subid < 40) {
> > +		optr[0] = 0;
> > +		optr[1] = subid;
> > +	} else if (subid < 80) {
> > +		optr[0] = 1;
> > +		optr[1] = subid - 40;
> > +	} else {
> > +		optr[0] = 2;
> > +		optr[1] = subid - 80;
> > +	}
> > +
> > +	*len = 2;
> > +	optr += 2;
> > +
> > +	while (ctx->pointer < eoc) {
> > +		if (++(*len) > size) {
> > +			ctx->error = ASN1_ERR_DEC_BADVALUE;
> > +			kfree(*oid);
> > +			*oid = NULL;
> > +			return 0;
> > +		}
> > +
> > +		if (!asn1_subid_decode(ctx, optr++)) {
> > +			kfree(*oid);
> > +			*oid = NULL;
> > +			return 0;
> > +		}
> > +	}
> > +	return 1;
> > +}
> 
> Still bool.
Okay.
> 
> > +
> > +static int
> > +compare_oid(unsigned long *oid1, unsigned int oid1len,
> > +	    unsigned long *oid2, unsigned int oid2len) {
> > +	unsigned int i;
> > +
> > +	if (oid1len != oid2len)
> > +		return 0;
> > +
> > +	for (i = 0; i < oid1len; i++) {
> > +		if (oid1[i] != oid2[i])
> > +			return 0;
> > +	}
> > +	return 1;
> > +}
> 
> Call this oid_eq()?
Why not compare_oid()? This code is come from cifs.
I need clear reason to change both cifs/cifsd...

> 
> 
> > +
> > +/* BB check for endian conversion issues here */
> > +
> > +int
> > +ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
> > +		    struct ksmbd_conn *conn)
> > +{
> > +	struct asn1_ctx ctx;
> > +	unsigned char *end;
> > +	unsigned char *sequence_end;
> > +	unsigned long *oid = NULL;
> > +	unsigned int cls, con, tag, oidlen, rc, mechTokenlen;
> > +	unsigned int mech_type;
> > +
> > +	ksmbd_debug(AUTH, "Received SecBlob: length %d\n", length);
> > +
> > +	asn1_open(&ctx, security_blob, length);
> > +
> > +	/* GSSAPI header */
> > +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> > +		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
> > +		return 0;
> > +	} else if ((cls != ASN1_APL) || (con != ASN1_CON)
> 
> No need for else after a return 0;  Surely, checkpatch complains about
> || on the following line and the extra parentheses?
> 
> 	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> 		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
> 		return false;
> 	}
> 
> 	if (cls != ASN1_APL || con != ASN1_CON || tag != ASN1_EOC) {
> 		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
> 			    tag);
> 		return false;
> 	}
> 
> > +		   || (tag != ASN1_EOC)) {
> > +		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
> > +			tag);
> > +		return 0;
> > +	}
> > +
> > +	/* Check for SPNEGO OID -- remember to free obj->oid */
> > +	rc = asn1_header_decode(&ctx, &end, &cls, &con, &tag);
> > +	if (rc) {
> 
> This code confused the me at first.  I've always assumed "rc" stands for "return code" but
> asn1_header_decode() doesn't return error codes, it returns true false.  Alway do failure handling,
> instead of success handling.  That way when you're reading the code you can just read the code
> indented one tab to see what it does and the code indented two tabs to see how the error handling
> works.
> 
> Good:
> 
> 	frob();
> 	if (fail)
> 		clean up();
> 	frob();
> 	if (fail)
> 		clean up();
> 
> Bad:
> 	frob();
> 	if (success)
> 		frob();
> 		if (success)
> 			frob();
> 			if (success)
> 				frob();
> 		else
> 			fail = 1;
> 	if (fail)
> 		clean up();
> 
> So this code confused me.  Keep the ordering consistent with cls, con, and tag.  In fact just write it
> exactly like the lines before.
Okay.
> 
> 	if (!asn1_header_decode(&ctx, &end, &cls, &con, &tag)) {
> 		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
> 		return false;
> 	}
> 
> 	if (cls != ASN1_UNI || con != ASN1_PRI || tag != ASN1_OJI) {
> 		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
> 			    tag);
> 		return false;
> 	}
> 
> 	if (!asn1_oid_decode(&ctx, end, &oid, &oidlen))
> 		return false;
> 	if (!oid_equiv()) {
> 		free();
> 		return false;
> 	}
> 
> 	kfree(oid); <-- I added this
> 
> Add a kfree(oid) to the success path to avoid a memory leak.
> 
> > +		if ((tag == ASN1_OJI) && (con == ASN1_PRI) &&
> > +		    (cls == ASN1_UNI)) {
> > +			rc = asn1_oid_decode(&ctx, end, &oid, &oidlen);
> > +			if (rc) {
> > +				rc = compare_oid(oid, oidlen, SPNEGO_OID,
> > +						 SPNEGO_OID_LEN);
> > +				kfree(oid);
> > +			}
> > +		} else
> > +			rc = 0;
> > +	}
> > +
> > +	/* SPNEGO OID not present or garbled -- bail out */
> > +	if (!rc) {
> > +		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
> > +		return 0;
> > +	}
> > +
> > +	/* SPNEGO */
> > +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> > +		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
> > +		return 0;
> > +	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
> > +		   || (tag != ASN1_EOC)) {
> > +		ksmbd_debug(AUTH,
> > +			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
> > +			cls, con, tag, end, *end);
> > +		return 0;
> > +	}
> > +
> > +	/* negTokenInit */
> > +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> > +		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
> > +		return 0;
> > +	} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
> > +		   || (tag != ASN1_SEQ)) {
> > +		ksmbd_debug(AUTH,
> > +			"cls = %d con = %d tag = %d end = %p (%d) exit 1\n",
> > +			cls, con, tag, end, *end);
> > +		return 0;
> > +	}
> > +
> > +	/* sequence */
> > +	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
> > +		ksmbd_debug(AUTH, "Error decoding 2nd part of negTokenInit\n");
> > +		return 0;
> > +	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
> > +		   || (tag != ASN1_EOC)) {
> > +		ksmbd_debug(AUTH,
> > +			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
> > +			cls, con, tag, end, *end);
> > +		return 0;
> > +	}
> > +
> > +	/* sequence of */
> > +	if (asn1_header_decode
> > +	    (&ctx, &sequence_end, &cls, &con, &tag) == 0) {
> 
> 
> I just ran checkpatch.pl on your patch and I see that you actually fixed all the normal checkpatch.pl
> warnings.  But I'm used to checkpatch.pl --strict code because that's the default in net and staging.
> This file has 1249 little things like this where checkpatch would have said to write it like:
> 
> 	if (!asn1_header_decode(&ctx, &sequence_end, &cls, &con, &tag)) {
> 
> total: 1 errors, 1 warnings, 1249 checks, 24501 lines checked
> 
> Once a patch has over a thousand style issues then it's too much for me to handle.  :P
Okay, I'll run it with that option:)

Thanks for your review!
> 
> regards,
> dan carpenter


