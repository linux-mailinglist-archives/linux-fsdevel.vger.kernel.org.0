Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78A13D908
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgAPLc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 06:32:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPLc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:32:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so18779785wrm.11;
        Thu, 16 Jan 2020 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fHDp8wpwnk1e+4AQLh183cuj/e9JCo/lRZdnQTmnhCQ=;
        b=EgjnX20MN693f2oYUA6bZkJeWtKnnHOO9cfVk9X8pjthu0E2pPPG/dFzpR6WJY9uAr
         gXSxTlcInbwqwbtqOkXWm52hOOKQFLy+kq4lqqCI7fBZl+u2SSM2EW0B8IX1Lofvyk0p
         2eGU9ZAFZ86iErKOV0cPCmPDHYuSoSPc8fMHkFwZCoeoiLJ5iJB6sUh490t6XjRujPOp
         vRIz56pfWVjhC8Xi1I4A7C7+YOuohKUzfGQiKBguSKTuGyrjLET3JNZSw5Xitr556yQO
         MuSpK9sB4ggeYwGkY7SLa4zBQIAyBccBbUrFOUL5e7XmGNoSIOCuBUhh1I4pU8h5vsJQ
         fiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fHDp8wpwnk1e+4AQLh183cuj/e9JCo/lRZdnQTmnhCQ=;
        b=RcZiWQ4/OcEbmySqCf3+cboYmZ0E/NdpaXjqN/Y4sIdusXtkSgGJVYNxm+4PHwX+oe
         MpieKr3ToZ26qpbKnNOByycuSkFlBm18lTyZPOS2J+phQfO2o6HWDyTmVltFMBC3BKeB
         npVwUA/4vC5lbTM2VrBzoV7pA8NQcSTZ7aeHHe6xSQ4IUFQi30lLoZDnWiu8RqVo/qmr
         +jYK7rMU+6aqC+cdC+etJwvA0LiCMv7NDS3grRXI2MaTdmMRacd8htrhy549nud1Kxnb
         XKqKYy+JlWQss+nC9rnHyQNoyCydNyc9dteUtcWEG045WI+iclfwUGLkdVRXqjdExetr
         a4oA==
X-Gm-Message-State: APjAAAVTUyaGQwdTo/oOzvEEzyHE35Qdu94Wxiqv5uOSrc0O/h7OeEBv
        DZKw4R1lL/tuSZ8sYG6zfp0=
X-Google-Smtp-Source: APXvYqyfNxXXOxecRu+2vMB9msBdQG9jvQu4zW5qkema7FFIjEmivisbSVmrTNkx6nSNhfk5C78m1A==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr2824516wrt.367.1579174344405;
        Thu, 16 Jan 2020 03:32:24 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x14sm283489wmj.42.2020.01.16.03.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 03:32:23 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:32:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
Message-ID: <20200116113222.bmhks4bnzm77h3cq@pali>
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115094732.bou23s3bduxpnr4k@pali>
 <20200116105108.GA16924@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116105108.GA16924@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 16 January 2020 11:51:08 Christoph Hellwig wrote:
> On Wed, Jan 15, 2020 at 10:47:32AM +0100, Pali Rohár wrote:
> > Next steps for future:

I mean all points to be next future steps after merging. Not something
for this patch series. Sorry for a confusion.

-- 
Pali Rohár
pali.rohar@gmail.com
