Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893E31363BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgAIXYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:24:33 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12253 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:24:33 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200109232429epoutp03ecee8ed1cff57f3c608693beaf9e4c12~oW37kUYdx1758417584epoutp03F
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:24:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200109232429epoutp03ecee8ed1cff57f3c608693beaf9e4c12~oW37kUYdx1758417584epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578612269;
        bh=lMGhktOYLMYAWK+NX3Jxwp6jFGb6ANpkrOAtwzIsmMk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mfu8u1pLuwKKx6TlsCNmaVi7SyhTm2Dzj95Gd/iMqDyXrXk1Np7dMZxqatPt/Ji5m
         FikOCWwWRArHgQCgUSdR4vS9higngjhEAscDLzOGowxIY+CxUAWZIfHZrA5xHn21F2
         oPtQo0gu6D8S6jGVpqwcDct/R3vqb18IOSM0iPP4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200109232429epcas1p135bb753e048a10025a098dc3155ad6c0~oW37IuqvA1257212572epcas1p1g;
        Thu,  9 Jan 2020 23:24:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47v2JD3tBZzMqYkj; Thu,  9 Jan
        2020 23:24:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.5D.57028.C26B71E5; Fri, 10 Jan 2020 08:24:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109232428epcas1p281af6e3194bb3d30dd0344c1985a9909~oW3539uVp0905609056epcas1p2Z;
        Thu,  9 Jan 2020 23:24:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109232428epsmtrp10b042efa0a0d8cc9989a475b4755cee4~oW353Sdgd1664416644epsmtrp1I;
        Thu,  9 Jan 2020 23:24:28 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-0a-5e17b62c2468
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.37.06569.B26B71E5; Fri, 10 Jan 2020 08:24:28 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109232427epsmtip28b8384a785ef16b3fbc2060b81aa46b2~oW35rOzdi1016610166epsmtip2b;
        Thu,  9 Jan 2020 23:24:27 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        <pali.rohar@gmail.com>
In-Reply-To: <20200108180040.GB14650@lst.de>
Subject: RE: [PATCH v9 06/13] exfat: add exfat entry operations
Date:   Fri, 10 Jan 2020 08:24:27 +0900
Message-ID: <001901d5c743$eff08030$cfd18090$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwIyMVVdAji9BWUBuFo0Daa5OQYQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXbv7q7V7DbNHQxq3rBMUndb05to78giQyGKiHJd9OKsvbG7
        mdaHVpaaiSYG4iqSjFAzlJqm1VpZIlZEL5QVWBRlGr1oke9U2+4iv/3P8/zO+Z/zPIfEFK1E
        JJlntvM2M2ekiVl4+91lCXHL25VZ6ppqFVtU30KwjZe6JWxf/2uMvenpxdln188QbNWDKQnr
        /n1Pyj79PoyvJXWdrn6Zznu2Waa78cpJ6CrcTUj388pCXde1L0QmsdOYYuC5HN6m4s3Zlpw8
        c24qvXmrfoNem6hm4phVbBKtMnMmPpXemJ4Zl5Zn9DVEq/I5o8N3lMkJAp2wOsVmcdh5lcEi
        2FNp3ppjtDJqa7zAmQSHOTc+22JKZtTqFVofucdoeDE6iVsbZxfcqa4lnKiTLEMhJFAroazo
        IipDs0gF1YGg/f1NXAx+IPDenpKKwSiC4YZm9C/l28dzQcqDYGKgJ0gNIWj780nmpwgqDn5P
        ewm/DqeWwMOJYpkfwqj7CP60VQUuQqjlcL78fqBsGLUGxh8PSv0ap6LhcNNkgJFTq6CmpwMT
        9Tzorf2A+zVGLYJrX89gYksqmPh4USqapUHr9DEkMuFw+ngx5jcGqkgG/T0dEjFhI3gbnFJR
        h8HnHrdM1JEwVOnvlPTpgzDiDdYvRTA4lipqDbxqaZX6EYxaBi3XE8TjKOicOhu0DYVvv8ql
        YhU5lBYrRCQaKp7eDTawAMpKhmUnEe2aMZhrxmCuGQO4/pvVIbwJRfBWwZTLC4yVmfnbV1Bg
        W2O1HejUo/QuRJGIniM3hCmzFFIuXyg0dSEgMTpc3v0yIkshz+EKD/A2i97mMPJCF9L63r0K
        i5yfbfHtvtmuZ7QrNBoNuzIxKVGroZVycvzJbgWVy9n5fTxv5W3/8iRkSKQTzZntiY36VRuz
        aeBwaPeijC3JQ7o7l3fnDxaVegoyhPgxpiKmPu9IyXP3ifBJT8qAcd6ONgdS9lXSxafqD+yv
        G2nkmudrbjVEuyP2X01foN0eW1NHLn7cPjm17p5bPzF3/baEUBoGTHZPTPnRpRm7bvcderOX
        vVAe9m5779uxKKWExgUDx8RiNoH7C5NqXUDDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvK7ONvE4g02OFs2L17NZrFx9lMni
        +t1bzBZ79p5ksbi8aw6bxcTTv5kstvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbFJdNSmpOZllqkb5dAlfGtW+/WApWclccnDyTrYFxJ0cXIyeHhICJxLun
        81m6GLk4hAR2M0r0texjg0hISxw7cYa5i5EDyBaWOHy4GKLmOaPEukU7GUFq2AR0Jf792Q9W
        LyKgJnHmZxs7SBGzwCVGiQm9TcwQHfcZJbrnHmQCqeIU0JFY1HMKrFtYwF7ix4UXrCA2i4Cq
        ROOqX2CTeAUsJaYf38EMYQtKnJz5hAXkCmYBPYm2jWCtzALyEtvfzmGGOFRB4ufTZawQR7hJ
        bPjTClUjIjG7s415AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfm
        pesl5+duYgTHl5bWDsYTJ+IPMQpwMCrx8GYIi8cJsSaWFVfmHmKU4GBWEuE9ekMsTog3JbGy
        KrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAOj/7sk/t9rROy+bTuZ
        YHBIc+YTpm1XCtunCC317zb4deWDjqPE8/ilHaVnXsitawoNqnzcEPf697bbkge3Fe0O/Hzl
        4/07cxU17ry6EP9F6ItI+dF1t93LH0zIkz33dpehT/9J+ayo74vNL288wr73MKv5ymU3YrJn
        7/Ge5fI7/NPXnEUn2tfniiixFGckGmoxFxUnAgBBPMt/qwIAAA==
X-CMS-MailID: 20200109232428epcas1p281af6e3194bb3d30dd0344c1985a9909
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9@epcas1p4.samsung.com>
        <20200102082036.29643-7-namjae.jeon@samsung.com>
        <20200108180040.GB14650@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +int exfat_ent_get(struct super_block *sb, unsigned int loc,
> > +		unsigned int *content)
> > +{
> > +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> > +	int err;
> > +
> > +	if (!is_valid_cluster(sbi, loc)) {
> > +		exfat_fs_error(sb, "invalid access to FAT (entry 0x%08x)",
> > +			loc);
> > +		return -EIO;
> > +	}
> > +
> > +	err = __exfat_ent_get(sb, loc, content);
> > +	if (err) {
> > +		exfat_fs_error(sb,
> > +			"failed to access to FAT (entry 0x%08x, err:%d)",
> > +			loc, err);
> > +		return err;
> > +	}
> > +
> > +	if (!is_reserved_cluster(*content) &&
> > +			!is_valid_cluster(sbi, *content)) {
> > +		exfat_fs_error(sb,
> > +			"invalid access to FAT (entry 0x%08x) bogus content
> (0x%08x)",
> > +			loc, *content);
> > +		return -EIO;
> > +	}
> > +
> > +	if (*content == EXFAT_FREE_CLUSTER) {
> > +		exfat_fs_error(sb,
> > +			"invalid access to FAT free cluster (entry 0x%08x)",
> > +			loc);
> > +		return -EIO;
> > +	}
> > +
> > +	if (*content == EXFAT_BAD_CLUSTER) {
> > +		exfat_fs_error(sb,
> > +			"invalid access to FAT bad cluster (entry 0x%08x)",
> > +			loc);
> > +		return -EIO;
> > +	}
> > +	return 0;
> 
> Maybe these explicit checks should move up, and then is_reserved_cluster
> can be replaced with an explicit check just for EXFAT_EOF_CLUSTER?
Right, Will fix it on v10.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!

