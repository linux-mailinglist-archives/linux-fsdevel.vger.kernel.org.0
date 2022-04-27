Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAC511A80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbiD0Oel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiD0Oee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:34:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFDE1A811
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 07:31:12 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220427143111epoutp04550352ce9c81384ba3747c70cd69c980~px0zJucd92458624586epoutp04S
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 14:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220427143111epoutp04550352ce9c81384ba3747c70cd69c980~px0zJucd92458624586epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651069871;
        bh=crH6lA8CKSr3raD35a8WNJj9gNhvnxzuqz4w8DLYYGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fBEiAL09DVN+6O96oSHfHYfLa/Y0rXC6OWr8HMjDqmKMbmsTHamZ3k97hKG7YmF2/
         U2vK9ejkjv+6eatRrTbT5IhEm0Ymzg9tCefEY7cdhkQDb+GNpT7eoaHbK5wQ3IVfid
         FrF7T1W5R4YAg2LFLwPW7VJslUT919RYSUn/PsoI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220427143110epcas5p40c88d0aed948bf707494648074071e87~px0yta3Zx2356823568epcas5p4v;
        Wed, 27 Apr 2022 14:31:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KpLlZ5wJ5z4x9Pt; Wed, 27 Apr
        2022 14:31:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.DD.10063.9A359626; Wed, 27 Apr 2022 23:31:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220427130824epcas5p38594effe1d648be050ff00284e115014~pwshxFhMl2087820878epcas5p35;
        Wed, 27 Apr 2022 13:08:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427130824epsmtrp14e26381493d2df92a583d1f425e97e0c~pwshwRhe_3201832018epsmtrp1G;
        Wed, 27 Apr 2022 13:08:24 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-c5-626953a9862a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.A4.08853.84049626; Wed, 27 Apr 2022 22:08:24 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427130823epsmtip2faace445336901ad6bad32c4c8c06a3d~pwsghFvIJ1516015160epsmtip2s;
        Wed, 27 Apr 2022 13:08:23 +0000 (GMT)
Date:   Wed, 27 Apr 2022 18:33:15 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] block: Introduce a new ioctl for copy
Message-ID: <20220427130315.GB9558@test-zns>
MIME-Version: 1.0
In-Reply-To: <513edc25-1c73-6c85-9a50-0e267a106ec0@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmlu7K4Mwkg83dbBa/z55nttj7bjar
        xd5b2hZ79p5ksbi8aw6bxfxlT9ktuq/vYLPY8aSR0YHDY+esu+wem5fUe+xsvc/q8X7fVTaP
        z5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnbOndwFrwUrBiw71fjA2MLXxdjJwcEgImEkv3zWDtYuTiEBLYzSjRvXYulPOJUeLs
        wd9sEM43RomWxYcYYVpWX5sKVbWXUaK1+zhU1TNGieM7vrGDVLEIqEr0LF8AlODgYBPQljj9
        nwMkLCJgKvG2p5UFpJ5Z4AyjRPv7XWD1wgLOEv0XbzOD2LwCOhJ7D2xlg7AFJU7OfMICYnMK
        uElMPbaRCcQWFVCWOLDtOBPIIAmBVg6J91P2sUOc5yKx/Np3NghbWOLV8S1QcSmJl/1tUHa5
        xPa2BVDNLYwSXadOsUAk7CUu7vkLtoFZIEPiZP8TqEGyElNPrYOK80n0/n7CBBHnldgxD8ZW
        llizfgFUvaTEte+NULaHxJ9fkLATEvjNKHFuecQERvlZSJ6bhWQdhK0jsWD3JyCbA8iWllj+
        jwPC1JRYv0t/ASPrKkbJ1ILi3PTUYtMCw7zUcniUJ+fnbmIEJ1Utzx2Mdx980DvEyMTBeIhR
        goNZSYT3y+6MJCHelMTKqtSi/Pii0pzU4kOMpsDImsgsJZqcD0zreSXxhiaWBiZmZmYmlsZm
        hkrivKfTNyQKCaQnlqRmp6YWpBbB9DFxcEo1MDHuZMtnCveS5dyplbLtQ6yT1cyrqp+jNV78
        td50UtihS2znQbNss6ct9y5WSj7h4r/YvvP4l4mq586arxDgNPK0nbt2++XpMSyzTzCcP7bl
        5Ga9AMnSCYdmflilkdHO6ZLZYi2mdeBXw/qNYccOMUeXMonf3vhNMHH187VXs/esU5gVdm+R
        QH7+vZSl3Et/rs9sdvogqivX0XT8L7/GDZcT0a5aIZtfbT5d3nVm9QtZWSuWxw7PjrLxsXB6
        ZAepV1oo5Jr3P3lwnr2ghq1ZxsBld7Y03/5b/IwP31969ER6+s043U+n6j5ylorx68Wd7luj
        tu5F4JUE58n38kyZ060niWXO15t/W6h4z12VDCWW4oxEQy3mouJEAIGbFNYzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvK6HQ2aSwaIl0ha/z55nttj7bjar
        xd5b2hZ79p5ksbi8aw6bxfxlT9ktuq/vYLPY8aSR0YHDY+esu+wem5fUe+xsvc/q8X7fVTaP
        z5vkAlijuGxSUnMyy1KL9O0SuDKaL3IXrOSv2LThL2MD413uLkZODgkBE4nV16aydjFycQgJ
        7GaUeHP7DSNEQlJi2d8jzBC2sMTKf8/ZIYqeMEo03poDlmARUJXoWb6ArYuRg4NNQFvi9H8O
        kLCIgKnE255WFpB6ZoEzjBLt73exgySEBZwl+i/eBuvlFdCR2HtgKxvE0N+MEkveTmaFSAhK
        nJz5hAXEZhbQkrjx7yUTyAJmAWmJ5f/AFnAKuElMPbaRCcQWFVCWOLDtONMERsFZSLpnIeme
        hdC9gJF5FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcCRoae5g3L7qg94hRiYOxkOM
        EhzMSiK8X3ZnJAnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
        KdXAdHDXNQfr76ea8g6xxHUXtj65+s76sFXCrNy02EbZflWt4s8m8WmWhQxPPdznWvr0qJo5
        Zdl8rf1zY1c1R/y1JZ82m/OuXpJrPi9hS23woU4/0/Lo1nXzLrLdWXPw+pSD+Rk7bu3XYXDP
        P6ZzU9qc1UTn5oMFWsuZp9vy5K7NW5w8V/286MKagv+9svKreO4v+lszVWWhb+8WvuP+G3Ym
        nG8q/h5b8l38wV/NvALj/cZTT3quXejR71hYe6g79UiOzdrSezVVklPsvNUmu2qEVNfYPZ/y
        ovWVfEzu76ojTfskD5v4KDZznLvU9rdpsWa19anSOSXHvrBI9QcbR2+MCWdc7zc5J/o8m5/l
        pjQlluKMREMt5qLiRACj4ob+8wIAAA==
X-CMS-MailID: 20220427130824epcas5p38594effe1d648be050ff00284e115014
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_17950_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296@epcas5p2.samsung.com>
        <20220426101241.30100-4-nj.shetty@samsung.com>
        <513edc25-1c73-6c85-9a50-0e267a106ec0@opensource.wdc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_17950_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

O Wed, Apr 27, 2022 at 11:48:57AM +0900, Damien Le Moal wrote:
> On 4/26/22 19:12, Nitesh Shetty wrote:
> > Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> > to one or more destination in a device. COPY ioctl accepts a 'copy_range'
> > structure that contains no of range, a reserved field , followed by an
> > array of ranges. Each source range is represented by 'range_entry' that
> > contains source start offset, destination start offset and length of
> > source ranges (in bytes)
> > 
> > MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> > MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> > 
> > Example code, to issue BLKCOPY:
> > /* Sample example to copy three entries with [dest,src,len],
> > * [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device */
> > 
> > int main(void)
> > {
> > 	int i, ret, fd;
> > 	unsigned long src = 0, dst = 32768, len = 4096;
> > 	struct copy_range *cr;
> > 	cr = (struct copy_range *)malloc(sizeof(*cr)+
> > 					(sizeof(struct range_entry)*3));
> > 	cr->nr_range = 3;
> > 	cr->reserved = 0;
> > 	for (i = 0; i< cr->nr_range; i++, src += len, dst += len) {
> > 		cr->range_list[i].dst = dst;
> > 		cr->range_list[i].src = src;
> > 		cr->range_list[i].len = len;
> > 		cr->range_list[i].comp_len = 0;
> > 	}
> > 	fd = open("/dev/nvme0n1", O_RDWR);
> > 	if (fd < 0) return 1;
> > 	ret = ioctl(fd, BLKCOPY, cr);
> > 	if (ret != 0)
> > 	       printf("copy failed, ret= %d\n", ret);
> > 	for (i=0; i< cr->nr_range; i++)
> > 		if (cr->range_list[i].len != cr->range_list[i].comp_len)
> > 			printf("Partial copy for entry %d: requested %llu, completed %llu\n",
> > 								i, cr->range_list[i].len,
> > 								cr->range_list[i].comp_len);
> > 	close(fd);
> > 	free(cr);
> > 	return ret;
> > }
> 
> Nice to have a code example. But please format it correctly.
>

acked

--
Nitesh Shetty

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_17950_
Content-Type: text/plain; charset="utf-8"


------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_17950_--
