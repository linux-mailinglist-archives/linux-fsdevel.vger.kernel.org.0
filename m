Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3386465889F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 03:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiL2C0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 21:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiL2C0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:26:08 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002012748
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 18:26:04 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221229022600epoutp011baa635b1e3697e6210edf421c2856c7~1In29eX1j3155531555epoutp014
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 02:26:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221229022600epoutp011baa635b1e3697e6210edf421c2856c7~1In29eX1j3155531555epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672280760;
        bh=yCfFymG1uGMcGI1YQBEefKbvvmKH1U9EW84umDT7dwA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=IKa3QQT++yVlltGSXfVrQZQfqtEIp72+mJlaKgmi2jS1rGAWC5VsOu/S+reCpr8oW
         wDXnANhqI2KV/cV9OHyzj7vwbLqVblziJz2ikW/4SG+gOfOkOffCPfWagiYRj0gqqS
         8XPCvE85UfcLsa00gBUkjWQmq8xN9XAC42levN2I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221229022559epcas1p29ced4249e8f80e6e4fd0c506ea3ac39f~1In2ziOVw1633416334epcas1p26;
        Thu, 29 Dec 2022 02:25:59 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NjC1M45C2z4x9Q0; Thu, 29 Dec
        2022 02:25:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.FF.02461.7BAFCA36; Thu, 29 Dec 2022 11:25:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221229022559epcas1p2bffa37c9ec99b5d50438be6e8f01d575~1In2Mfrbk1633416334epcas1p25;
        Thu, 29 Dec 2022 02:25:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221229022559epsmtrp2ed673c6c8a3ff0ccf102d4d0543d571f~1In2Lzsn80461104611epsmtrp2c;
        Thu, 29 Dec 2022 02:25:59 +0000 (GMT)
X-AuditID: b6c32a37-873ff7000000099d-c2-63acfab7851d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.93.02211.7BAFCA36; Thu, 29 Dec 2022 11:25:59 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221229022559epsmtip1a0bb3e7645deebb11182b47d33dee376~1In2CXqJT0385503855epsmtip1I;
        Thu, 29 Dec 2022 02:25:59 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Wang Yugui'" <wangyugui@e16-tech.com>
In-Reply-To: <PUZPR04MB6316182889B5CE8003A5324981EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] exfat: fix unexpected EOF while reading dir
Date:   Thu, 29 Dec 2022 11:25:58 +0900
Message-ID: <019201d91b2c$e34ee610$a9ecb230$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLMYJ9qc07sXglr1cn65GyOp8Tb9AJty/lfrIoppXA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmvu72X2uSDSa+UrCYOG0ps8WevSdZ
        LC7vmsNm8WDeF3YHFo/Vz+YweWxa1cnm8XmTXABzVAOjTWJRckZmWapCal5yfkpmXrqtUmiI
        m66FkkJGfnGJrVK0oaGRnqGBuZ6RkZGesWWslZGpkkJeYm6qrVKFLlSvkkJRcgFQbW5lMdCA
        nFQ9qLhecWpeikNWfinIiXrFibnFpXnpesn5uUoKZYk5pUAjlPQTGpkz5s04xFrwkbvizgGb
        BsYtnF2MHBwSAiYSR/+xdTFycQgJ7GCUmNXylxHC+cQosXHnNxYI5xujxIfZb9i7GDnBOnbO
        28wMkdjLKPFy/zl2COclo8SN49NZQarYBHQlntz4yQxiiwhIS8y7OIUJZB+zQJ7E+ZsxICan
        QKzElP35IBXCAs4SKyf2gVWwCKhKNL1yBwnzClhKXFt0gg3CFpQ4OfMJC4jNLCAvsf3tHGaI
        cxQkdn86ygqxyEri3fmrjBA1IhKzO9vAzpQQ+Mgu8a7rMhtEg4vEivP3WSFsYYlXx7dA/SUl
        8fndXjaIhm5GieMf37FAJGYwSizpcICw7SWaW5vZIF7RlFi/Sx8irCix8/dcRghbUOL0tW5m
        iCP4JN597WGFhDSvREebEESJisT3DztZJjAqz0Ly2iwkr81C8sIshGULGFlWMYqlFhTnpqcW
        GxYYI0f2JkZw4tQy38E47e0HvUOMTByMhxglOJiVRHg1zq5OFuJNSaysSi3Kjy8qzUktPsQ4
        kREY2BOZpUST84HJO68k3tDMzNLC0sjE0NjM0JCwsImxgYERMMmaW5obEyFsaWBiZmRiYWxp
        bKYkzpu/f1GykEB6YklqdmpqQWoRzFFMHJxSDUwB7EZb1noLy0btf3Lpx57Dp6tvG/yfb7zv
        tZrNz6VcCvazDLt8MxOy2TKidjDWaDsenj6pRyk6osF290ePg6krTS4XPyt2ZH25rqHfmUVk
        1uzF646Zrp7zpI/7aG2CyOu918MuWMVP+fVkzskd92Wa9DlnBBzxWchjOvuNYpfSiZWXuXX/
        thY/l910OmOCu2rLnn8ninkzf4t1qmV+c53O3ZK4JGRlGtOvjR/45905tcrexLOnR/1gxkbW
        +2amezIrnvA+tubXil7guyMtPv9QXPlN+aeC3/dFyIWab35yZPKth1NK9aeVPb7+l/PQx3+h
        uU/s9DdUGaS9XrW9qT0899KZCE7/pH/VZwx21L5VYinOSDTUYi4qTgQAkhUPkIIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO72X2uSDR7d5raYOG0ps8WevSdZ
        LC7vmsNm8WDeF3YHFo/Vz+YweWxa1cnm8XmTXABzFJdNSmpOZllqkb5dAlfGvBmHWAs+clfc
        OWDTwLiFs4uRk0NCwERi57zNzF2MXBxCArsZJc51z2fsYuQASkhJHNynCWEKSxw+XAxR8pxR
        4uK8I8wgvWwCuhJPbvwEs0UEpCXmXZzCBGIzCxRIHHr3nA2iYR2jxJdTX1lABnEKxEpM2Z8P
        UiMs4CyxcmIfE0iYRUBVoumVO0iYV8BS4tqiE2wQtqDEyZlPWCBGakv0PmxlhLDlJba/ncMM
        cb6CxO5PR1khTrCSeHf+KlSNiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3PbfY
        sMAwL7Vcrzgxt7g0L10vOT93EyM4KrQ0dzBuX/VB7xAjEwfjIUYJDmYlEV6Ns6uThXhTEiur
        Uovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBS/e05IbXA80Is37bY
        7JpdWy5obNg649glkzssE803G8r9T+de32bn2Xa+aKpfzTbD45eFdl96uVT3yMNta7o3tebq
        v+LSurhdaVrvoZvpW3zFXIqeNDtec1i8o/PkmsyfRn0NRfX2tqvWH1RvfX1mXRCvZLaFRMCM
        vg27vRYr5DSdebj5xo4NQr82P0gzecj6XOdY1MW+ux3LFa/8l1jY/r6AY3JjD+vBls8dtzYE
        GWo7v5dZdKN8Yyj/0Q/LpmUvu/62O0es2zFo480wx8o3qyoMjKU0dihcWPnJ+LIw6wo9/9c/
        //wx9E4oYw6Wyria/ePP4+MXdq5kfGO448wyj1wdIcdonVT7zSZxM3keKbEUZyQaajEXFScC
        AKnoR1/5AgAA
X-CMS-MailID: 20221229022559epcas1p2bffa37c9ec99b5d50438be6e8f01d575
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221226072359epcas1p4fa9052333561109f76db171f4c57324a
References: <CGME20221226072359epcas1p4fa9052333561109f76db171f4c57324a@epcas1p4.samsung.com>
        <PUZPR04MB6316182889B5CE8003A5324981EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If the position is not aligned with the dentry size, the return
> value of readdir() will be NULL and errno is 0, which means the
> end of the directory stream is reached.
> 
> If the position is aligned with dentry size, but there is no file
> or directory at the position, exfat_readdir() will continue to
> get dentry from the next dentry. So the dentry gotten by readdir()
> may not be at the position.
> 
> After this commit, if the position is not aligned with the dentry
> size, round the position up to the dentry size and continue to get
> the dentry.
> 
> Fixes: ca06197382bd ("exfat: add directory operations")
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>

Looks good. Thanks.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 1dfa67f307f1..1122bee3b634 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -234,10 +234,7 @@ static int exfat_iterate(struct file *file, struct
> dir_context *ctx)
>  		fake_offset = 1;
>  	}
> 
> -	if (cpos & (DENTRY_SIZE - 1)) {
> -		err = -ENOENT;
> -		goto unlock;
> -	}
> +	cpos = round_up(cpos, DENTRY_SIZE);
> 
>  	/* name buffer should be allocated before use */
>  	err = exfat_alloc_namebuf(nb);
> --
> 2.25.1

