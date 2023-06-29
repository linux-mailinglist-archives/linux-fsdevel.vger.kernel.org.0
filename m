Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D9742347
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjF2JaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjF2J3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:29:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F253AAF;
        Thu, 29 Jun 2023 02:28:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666683eb028so294169b3a.0;
        Thu, 29 Jun 2023 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688030933; x=1690622933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TixOk+GrnwG7LUBSuYVblGjuwa6NqVZBWGFPqeF40bA=;
        b=islYwuEpBCcQD04W+J7nH4klR4a3GV0utsWdggICHkMexZFQG/MFXgtNaFzFBw35yQ
         5B8wc5TUNOGE/lrpfDuKGAgIqgnkBxmtJsn1U795Ij/wHfobJ+lYhQavX0McKbArqg+K
         VrbmqzJB3/VGXIaoWfIyWmCJuywpSuORkOFvH4IxZybGktmfTXjbJnQlBme76ZCRhFrZ
         apFQp/ZA2tX/V6wrjflFzzEF9frmiaEi4/+Efr5N/lJSuqp9rdy1fpnGLDJe9w3ohqSj
         z0plzeIkWJaG5uKpX5KTT1qr+QMDIuCQZyn5kTbm80i9wfl1isdR9Q6strJevb3geswt
         r45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030933; x=1690622933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TixOk+GrnwG7LUBSuYVblGjuwa6NqVZBWGFPqeF40bA=;
        b=NjV3TLEZSiagb6Y63iaBhGZvNBL58Xhld6Tk757NooNrsMwKSjUkd5bpbmcOjPibYZ
         qM5mfjNrT4MD0+OlYV6KDv97xYA7nKwn6MrRZ/M5Jyrhm9jjTN2JJ2ADLfFpycMV8kMC
         mBtK2wFly6Z7aoannkkb4cn57GXLtkIkPonoPS1sfplcjwDddFq34W86ridBRbw89W2p
         wWONXx+m2snd/5sedEXhlEzRswdRVzokswo7+gQRjZf/c/w0cO2CkyG/2oIJS9HibSRU
         NmKqZ7G/jxCUAiMLcKpBvyFwLjJ/FpO1m4c3bnykDAgrgkGTAgFBEy0MVo5neDTbjr6H
         ZDWw==
X-Gm-Message-State: AC+VfDxz0QkG8c4+YYulenjRtsaEXQW85oKjNtDWMISP3Ku67XiW60t4
        BouCZpcctJI9f3RhllZZA+k=
X-Google-Smtp-Source: ACHHUZ77GxeC09rO+NpJj2OCrvUnmjf+hO+xe3A/cr9ByrtveEEsw+UA3FAJbhlHB+TWoUbfJDSjRA==
X-Received: by 2002:a05:6a00:139f:b0:676:4c90:ca60 with SMTP id t31-20020a056a00139f00b006764c90ca60mr11224028pfg.7.1688030932771;
        Thu, 29 Jun 2023 02:28:52 -0700 (PDT)
Received: from sumitra.com ([117.255.148.2])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b006468222af91sm8123137pfn.48.2023.06.29.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:28:52 -0700 (PDT)
Date:   Thu, 29 Jun 2023 02:28:44 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <20230629092844.GA456505@sumitra.com>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJxqmEVKoxxftfXM@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:15:04PM +0100, Matthew Wilcox wrote:
> Here's a more comprehensive read_folio patch.  It's not at all
> efficient, but then if we wanted an efficient vboxsf, we'd implement
> vboxsf_readahead() and actually do an async call with deferred setting
> of the uptodate flag.  I can consult with anyone who wants to do all
> this work.
> 
> I haven't even compiled this, just trying to show the direction this
> should take.
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 2307f8037efc..f1af9a7bd3d8 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -227,26 +227,31 @@ const struct inode_operations vboxsf_reg_iops = {
>  
>  static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct page *page = &folio->page;
>  	struct vboxsf_handle *sf_handle = file->private_data;
> -	loff_t off = page_offset(page);
> -	u32 nread = PAGE_SIZE;
> -	u8 *buf;
> +	loff_t pos = folio_pos(folio);
> +	size_t offset = 0;
>  	int err;
>  
> -	buf = kmap(page);
> +	do {
> +		u8 *buf = kmap_local_folio(folio, offset);
> +		u32 nread = PAGE_SIZE;
>  
> -	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
> -	if (err == 0) {
> -		memset(&buf[nread], 0, PAGE_SIZE - nread);
> -		flush_dcache_page(page);
> -		SetPageUptodate(page);
> -	} else {
> -		SetPageError(page);
> -	}
> +		err = vboxsf_read(sf_handle->root, sf_handle->handle, pos,
> +				&nread, buf);
> +		if (nread < PAGE_SIZE)
> +			memset(&buf[nread], 0, PAGE_SIZE - nread);
> +		kunmap_local(buf);
> +		if (err)
> +			break;
> +		offset += PAGE_SIZE;
> +		pos += PAGE_SIZE;
> +	} while (offset < folio_size(folio);
>  
> -	kunmap(page);
> -	unlock_page(page);
> +	if (!err) {
> +		flush_dcache_folio(folio);
> +		folio_mark_uptodate(folio);
> +	}
> +	folio_unlock(folio);
>  	return err;
>  }
>

Hi 

So, after reading the comments, I understood that the problem presented 
by Hans and Matthew is as follows:

1) In the current code, the buffers used by vboxsf_write()/vboxsf_read() are 
translated to PAGELIST-s before passing to the hypervisor, 
but inefficiently— it first maps a page in vboxsf_read_folio() and then 
calls page_to_phys(virt_to_page()) in the function hgcm_call_init_linaddr(). 

The inefficiency in the current implementation arises due to the unnecessary 
mapping of a page in vboxsf_read_folio() because the mapping output, i.e. the 
linear address, is used deep down in file 'drivers/virt/vboxguest/vboxguest_utils.c'. 
Hence, the mapping must be done in this file; to do so, the folio must be passed 
until this point. It can be done by adding a new member, 'struct folio *folio', 
in the 'struct vmmdev_hgcm_function_parameter64'. 

The unused member 'phys_addr' in this struct can also be removed.

2) Expanding the vboxsf_read_folio so that it can handle larger folios.
Matthew already has suggested the changes, I have to read more on this.

Parallelly I will be setting up the testing environment to test the changes. 


Please let me know if I am wrong anywhere.

Thanks & regards
Sumitra
