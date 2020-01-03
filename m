Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9109912F836
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 13:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgACMbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 07:31:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46079 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACMbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:31:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so42242246wrj.12;
        Fri, 03 Jan 2020 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gaDoAhZd9EnaspVB4eu0gwSjufuz8gDsIlWz8yJvXtw=;
        b=VcRSqbgYZo3yVNNTLQdNTjczb8TSz9OxqCgbbSA9u77KVFJkc8bGA1ixOK/DDwqLCz
         XyZhM+tubMWWju2gVJGndu68rjJzx8OVqp52oIs/NMvAGdV/Tx4R5JuvkRJ6495F8elv
         bpuXLSu+Fq/RRb08Ri+or9H6dMjRzaPPmAsVbbpKN/1YOmD7ZN5ACFqlTesqQwc9EmBE
         /c7FdatTDALlXl5IRi/VmkpdUTRax57bgIPzvqrbjg9yCxV+yoxW7sO8F/PP0FA7Ppbk
         Nhh5nkl5oZosjZzTX9huhmfFKtATdDMOBL499WgfX5kyxmoGKoTRt5iBoAD5W40/wRWz
         wbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gaDoAhZd9EnaspVB4eu0gwSjufuz8gDsIlWz8yJvXtw=;
        b=FcFBMZmpFLm91NHWqwj0su+OLHWW5/OX58hBRdnthiqlikKUFH94efPoFfyW1FIhNd
         Bns7Yv2WuPd7BOCL09cG7P/c9g98mHY4XYy4JsJfp/LHOoELRbE+F9GnmKsXAENhbbrO
         274W1dLDUqs4d/Pq86SP+yEJ/wx7BfJLtGewSEpnrPoc1bWZRif9kSUgZfiEPrz8NFoK
         JQH0h6TaAXHptSLW6PhApsluxJYsZjuY/Tnxhbks1/IS8vECQDmnPnHz2zEXJwbMFMa1
         V/uk63i07ejZfdM0JPXDDGDXPDiz7Mw0kW1cZPGfVhvejf3o1OqzvWvdrZKN5F2AipKH
         ersQ==
X-Gm-Message-State: APjAAAWSC7875K5+sZWJLWNKuopZcY6POGTUb0U9mwfdBskCKaDP1xkW
        zgKFpQgNGQvwVdeljeKBAIs=
X-Google-Smtp-Source: APXvYqxi3dX6vftLY+XF/wFxY2bTL8Q353b1cvgiRi64Bv5qa7kenkIw1qh4+D8MoP3iMsP/yEJiCQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr88071919wrm.293.1578054676319;
        Fri, 03 Jan 2020 04:31:16 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q11sm59035802wrp.24.2020.01.03.04.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 04:31:15 -0800 (PST)
Date:   Fri, 3 Jan 2020 13:31:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200103123114.vm23vqag5dbry2mu@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
 <20200103094030.zg4p5bqos32gc4hy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103094030.zg4p5bqos32gc4hy@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 03 January 2020 10:40:30 Pali Rohár wrote:
> On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> > This adds the implementation of nls operations for exfat.
> > 
> > Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > ---
> >  fs/exfat/nls.c | 809 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 809 insertions(+)
> >  create mode 100644 fs/exfat/nls.c
> > 
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > new file mode 100644
> > index 000000000000..af52328e28ff
> > --- /dev/null
> > +++ b/fs/exfat/nls.c
> 
> ...
> 
> > +static int exfat_convert_uni_to_ch(struct nls_table *nls, unsigned short uni,
> > +		unsigned char *ch, int *lossy)
> > +{
> > +	int len;
> > +
> > +	ch[0] = 0x0;
> > +
> > +	if (uni < 0x0080) {
> > +		ch[0] = uni;
> > +		return 1;
> > +	}
> > +
> > +	len = nls->uni2char(uni, ch, MAX_CHARSET_SIZE);
> > +	if (len < 0) {
> > +		/* conversion failed */
> > +		if (lossy != NULL)
> > +			*lossy |= NLS_NAME_LOSSY;
> > +		ch[0] = '_';
> > +		return 1;
> > +	}
> > +	return len;
> > +}
> 
> Hello! This function takes one UCS-2 character in host endianity and
> converts it to one byte (via specified 8bit encoding).
> 
> > +static int __exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> > +		struct exfat_uni_name *p_uniname, unsigned char *p_cstring,
> > +		int buflen)
> > +{
> > +	int i, j, len, out_len = 0;
> > +	unsigned char buf[MAX_CHARSET_SIZE];
> > +	const unsigned short *uniname = p_uniname->name;
> > +	struct nls_table *nls = EXFAT_SB(sb)->nls_io;
> > +
> > +	i = 0;
> > +	while (i < MAX_NAME_LENGTH && out_len < (buflen - 1)) {
> > +		if (*uniname == '\0')
> > +			break;
> > +
> > +		len = exfat_convert_uni_to_ch(nls, *uniname, buf, NULL);
> > +		if (out_len + len >= buflen)
> > +			len = buflen - 1 - out_len;
> > +		out_len += len;
> > +
> > +		if (len > 1) {
> > +			for (j = 0; j < len; j++)
> > +				*p_cstring++ = buf[j];
> > +		} else { /* len == 1 */
> > +			*p_cstring++ = *buf;
> > +		}
> > +
> > +		uniname++;
> > +		i++;
> > +	}
> > +
> > +	*p_cstring = '\0';
> > +	return out_len;
> > +}
> > +
> 
> This function takes UCS-2 buffer in host endianity and converts it to
> string in specified 8bit encoding.
> 
> > +
> > +int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> > +		struct exfat_uni_name *uniname, unsigned char *p_cstring,
> > +		int buflen)
> > +{
> 
> Looking at the code and this function is called from dir.c to translate
> exfat filename buffer stored in filesystem to format expected by VFS
> layer.
> 
> On exfat filesystem file names are always stored in UTF-16LE...
> 
> > +	if (EXFAT_SB(sb)->options.utf8)
> > +		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
> > +				buflen);
> > +	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring, buflen);
> 
> ... and therefore above "__exfat_nls_uni16s_to_vfsname" function must
> expect UTF-16LE buffer and not just UCS-2 buffer in host endianity.
> 
> So two other things needs to be done: Convert character from little
> endian to host endianity and then process UTF-16 buffer and not only
> UCS-2.
> 
> I see that in kernel NLS module is missing a function for converting
> UTF-16 string to UTF-32 (encoding in which every code point is
> represented just by one u32 variable). Kernel has only utf16s_to_utf8s()
> and utf8_to_utf32().

What about just filtering two u16 (one surrogate pair)? Existing NLS
modules do not support code points above U+FFFF so two u16 (one
surrogate pair) just needs to be converted to one replacement character.

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 81d75aed9..f626a0a89 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -545,7 +545,10 @@ static int __exfat_nls_vfsname_to_utf16s(struct super_block *sb,
 	return unilen;
 }
 
-static int __exfat_nls_uni16s_to_vfsname(struct super_block *sb,
+#define SURROGATE_PAIR		0x0000d800
+#define SURROGATE_LOW		0x00000400
+
+static int __exfat_nls_utf16s_to_vfsname(struct super_block *sb,
 		struct exfat_uni_name *p_uniname, unsigned char *p_cstring,
 		int buflen)
 {
@@ -559,7 +562,23 @@ static int __exfat_nls_uni16s_to_vfsname(struct super_block *sb,
 		if (*uniname == '\0')
 			break;
 
-		len = exfat_convert_uni_to_ch(nls, *uniname, buf, NULL);
+		if ((*uniname & SURROGATE_MASK) != SURROGATE_PAIR) {
+			len = exfat_convert_uni_to_ch(nls, *uniname, buf, NULL);
+		} else {
+			/* Process UTF-16 surrogate pair as one character */
+			if (!(*uniname & SURROGATE_LOW) && i+1 < MAX_NAME_LENGTH &&
+			    (*(uniname+1) & SURROGATE_MASK) == SURROGATE_PAIR &&
+			    (*(uniname+1) & SURROGATE_LOW)) {
+				uniname++;
+				i++;
+			}
+			/* UTF-16 surrogate pair encodes code points above Ux+FFFF.
+			 * Code points above U+FFFF are not supported by kernel NLS
+			 * framework therefore use replacement character */
+			len = 1;
+			buf[0] = '_';
+		}
+
 		if (out_len + len >= buflen)
 			len = buflen - 1 - out_len;
 		out_len += len;
@@ -623,7 +642,7 @@ int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
 	if (EXFAT_SB(sb)->options.utf8)
 		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
 				buflen);
-	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring, buflen);
+	return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring, buflen);
 }
 
 int exfat_nls_vfsname_to_uni16s(struct super_block *sb,

I have not tested this code, it is just an idea how to quick & dirty
solve this problem that NLS framework works with UCS-2 encoding and
UCS-4/UTF-32 or UTF-16.

> > +}
> 
> Btw, have you tested this exfat implementation on some big endian
> system? I think it cannot work because of missing conversion from
> UTF-16LE to UTF-16 in host endianity (therefore UTF-16BE).

Now I figured out that conversion from UTF-16LE to UTF-16 host endianity
is already done in exfat_extract_uni_name() function, called from
exfat_get_uniname_from_ext_entry() function. exfat_nls_uni16s_to_vfsname
is then called on result from exfat_get_uniname_from_ext_entry(), so
UTF-16LE processing on big endian systems should work. Sorry for that.

-- 
Pali Rohár
pali.rohar@gmail.com
