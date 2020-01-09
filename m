Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A741B136345
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 23:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgAIWfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 17:35:55 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:54756 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgAIWfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:35:54 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200109223550epoutp033551a2d5944f468d35124573c7e823d6~oWNcpGhp71448014480epoutp03R
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 22:35:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200109223550epoutp033551a2d5944f468d35124573c7e823d6~oWNcpGhp71448014480epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578609350;
        bh=z82DJGq6KvctY04fST+YnPNcQ2/ex4x3CjUldnlQABE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Nwi5l+BBCcdv1a6FKhxuutkvRi0QKmN6wpzBJ6HTxA7hwRHh3HyR77iovNUVO2GOS
         TuXGIbzgx3o4DACmaQXWUNknK02Oar1HlueNs3wzuvRf8n3EdIC5P7Slis5y4XC2L/
         lxDwjUjQIptnuq4jrjudL86VrJj0qYLu3PosB9VE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200109223549epcas1p1092093b42b4bc98c1d779931703a64ba~oWNb9E1AK2805228052epcas1p18;
        Thu,  9 Jan 2020 22:35:49 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47v1D41NyXzMqYkZ; Thu,  9 Jan
        2020 22:35:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.04.52419.4CAA71E5; Fri, 10 Jan 2020 07:35:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109223547epcas1p294286223ef261fde9660bd3f84176e8b~oWNaHIY8X1342013420epcas1p2u;
        Thu,  9 Jan 2020 22:35:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109223547epsmtrp1e266119c803d9c89633e7d23d3b211cb~oWNaGWDM_2014820148epsmtrp1k;
        Thu,  9 Jan 2020 22:35:47 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-94-5e17aac4c19b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.94.10238.3CAA71E5; Fri, 10 Jan 2020 07:35:47 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109223547epsmtip223b125c0a82fbbbf562e5c8ef8093e5b~oWNZ6bYZv1121411214epsmtip2I;
        Thu,  9 Jan 2020 22:35:47 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?utf-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>
In-Reply-To: <20200103123114.vm23vqag5dbry2mu@pali>
Subject: RE: [PATCH v9 10/13] exfat: add nls operations
Date:   Fri, 10 Jan 2020 07:35:47 +0900
Message-ID: <001401d5c73d$2349f6c0$69dde440$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwHz+Lr1AtmMBwQBuxR+cAG/bs6dpqgEPiA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD163a3W7S4FpAJBq2r/IAEaC2l64Ex8aoKijFqMJG6oRtK7JVu
        a0T/oBjAavAKUSsQlYixKiA2yiFiUGJU8MB4oOIRNWCDoKioQattFyP/3sy8mTcXiclriBgy
        z+Lg7BbWRBNh4kvX45MSb3iis5XffDhTWFVLMGfOtouYJz3PMOZKyy0x87CpnGAO3BkRMV7/
        DZzpGvwkXkDqGt09El1rxTmJrrm7gNCVej1I96V+qq7tcj+RSWwwzTNyrIGzKzhLjtWQZ8lN
        o1es0S/Ua1KVqkTVbEZLKyysmUujF6VnJi7JMwUaohVbWJMz4MpkeZ5Onj/PbnU6OIXRyjvS
        aM5mMNlUSlsSz5p5pyU3KcdqnqNSKmdpAsxNJmNheTFmc0VsPVQ4gBeg3+EuRJJApUB3Z5YL
        hZFyqgGBr++kRDCGEFxr7Bg1hhF0PfKIXUgayvB6r0qCWE61INjzdplA+oDg3vNKFAwQVCL4
        f7USQRxJMdDQ/p0IkjDqGoI3NRfwYEBKqWHXm+EQKYLSQv+pnlBVMRUHZf0uURDLqNng+lpP
        CHgS3Dr6LtQFRk2Dyx/LMaEjBfx8X40LYiuhdt9NXOBEwrHdRVhQGKg/BByu/i0REhaB/3wx
        LuAI8N30jvpj4MO+IomwmO3wuXW0fgmCvu9pAlZDd20dHqRgVDzUNiUL7unQOFKBBNlwGPi2
        FxeqyKCkSC5Q4qC067pIwFPAVfxJsh/R7jGDuccM5h4zgPu/2HEk9qDJnI0353K8yqYee+t6
        FPrVBG0Dqrub3oYoEtETZMaI6Gw5zm7h881tCEiMjpS1P52cLZcZ2PxtnN2qtztNHN+GNIG9
        H8BionKsgc+3OPQqzSy1Ws2kpGpTNWo6Wkb+eLBRTuWyDm4zx9k4+788ESmNKUCx40r7Xzj+
        nN5Z6Lt9ZKWzqvf+Ktn8zvFMhS+9rO615WhsTfeR5vCJ9rcnZ5xBfRmVkzIL4pKVzX2Prwy3
        XHo9N9YzFBb/LqHKMbPx7FrwT/Srdki/Lh+0aktbynqVQ6dta6Wv7i9e/5KLGrmYP6hYasjo
        Wd2x/cTB3nzIKunSN62jxbyRVSVgdp79C/RohRrBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO7hVeJxBjs+aVo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBYTT/9mstjy7wirxaX3H1gcODx2zrrL7rF/7hp2j903G9g8+ras
        YvT4vEnO49D2N2wBbFFcNimpOZllqUX6dglcGc1z2pkLuoQrJje/Y21g/MvXxcjJISFgIrFl
        yz72LkYuDiGB3YwS0/+sYoNISEscO3GGuYuRA8gWljh8uBii5jmjRM+qyUwgNWwCuhL//uwH
        qxcRsJDYcfQ7G0gRs8AJRokz/bdYITr6mCR+N85nBKniFDCWaHn4DaxDWMBc4s3Su+wgNouA
        qsTUN11gU3kFLCW6vmxig7AFJU7OfMICYjMLaEs8vfkUypaX2P52DjPEpQoSP58uY4W4wk9i
        ff9xVogaEYnZnW3MExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwlGlp7mC8vCT+EKMAB6MSD2+GsHicEGtiWXFl7iFGCQ5mJRHeozfE4oR4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgNNzl3Hb1w/wzV35c
        ne9SmXX8x5506TfXHj7PTJC7f3Sd3wvWfV/XenmvnuRz77Mqn8OkwnO3VU0YmyWaHP9eF9v6
        tM7Zd82HlvDFLZ6vwoNKH9m1/Zx5RPzUqg2ejqz3K07zzzI9JdyTukKoovDyk6K/amzXLn2/
        /d36wQZjlSzmHDP1GR09/UosxRmJhlrMRcWJALT+2RuuAgAA
X-CMS-MailID: 20200109223547epcas1p294286223ef261fde9660bd3f84176e8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
        <20200102082036.29643-11-namjae.jeon@samsung.com>
        <20200103094030.zg4p5bqos32gc4hy@pali>
        <20200103123114.vm23vqag5dbry2mu@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> What about just filtering two u16 (one surrogate pair)? Existing NLS
> modules do not support code points above U+FFFF so two u16 (one
> surrogate pair) just needs to be converted to one replacement character.
Hi Pali,

You're right.
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 81d75aed9..f626a0a89 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -545,7 +545,10 @@ static int __exfat_nls_vfsname_to_utf16s(struct
> super_block *sb,
>  	return unilen;
>  }
> 
> -static int __exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> +#define SURROGATE_PAIR		0x0000d800
> +#define SURROGATE_LOW		0x00000400
> +
> +static int __exfat_nls_utf16s_to_vfsname(struct super_block *sb,
>  		struct exfat_uni_name *p_uniname, unsigned char *p_cstring,
>  		int buflen)
>  {
> @@ -559,7 +562,23 @@ static int __exfat_nls_uni16s_to_vfsname(struct
> super_block *sb,
>  		if (*uniname == '\0')
>  			break;
> 
> -		len = exfat_convert_uni_to_ch(nls, *uniname, buf, NULL);
> +		if ((*uniname & SURROGATE_MASK) != SURROGATE_PAIR) {
> +			len = exfat_convert_uni_to_ch(nls, *uniname, buf,
> NULL);
> +		} else {
> +			/* Process UTF-16 surrogate pair as one character */
> +			if (!(*uniname & SURROGATE_LOW) && i+1 <
> MAX_NAME_LENGTH &&
> +			    (*(uniname+1) & SURROGATE_MASK) == SURROGATE_PAIR
> &&
> +			    (*(uniname+1) & SURROGATE_LOW)) {
> +				uniname++;
> +				i++;
> +			}
> +			/* UTF-16 surrogate pair encodes code points above
> Ux+FFFF.
> +			 * Code points above U+FFFF are not supported by
> kernel NLS
> +			 * framework therefore use replacement character */
> +			len = 1;
> +			buf[0] = '_';
> +		}
> +
>  		if (out_len + len >= buflen)
>  			len = buflen - 1 - out_len;
>  		out_len += len;
> @@ -623,7 +642,7 @@ int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
>  	if (EXFAT_SB(sb)->options.utf8)
>  		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
>  				buflen);
> -	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring,
> buflen);
> +	return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
> buflen);
>  }
> 
>  int exfat_nls_vfsname_to_uni16s(struct super_block *sb,
> 
> I have not tested this code, it is just an idea how to quick & dirty
> solve this problem that NLS framework works with UCS-2 encoding and
> UCS-4/UTF-32 or UTF-16.
I will check and test this code.
Thanks for your suggestion.

