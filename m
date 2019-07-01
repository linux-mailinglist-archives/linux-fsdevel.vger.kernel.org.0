Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC05BC28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 14:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfGAMye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 08:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbfGAMye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:54:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61CpoLu083800
        for <linux-fsdevel@vger.kernel.org>; Mon, 1 Jul 2019 08:54:32 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfgg7fn5c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2019 08:54:32 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 1 Jul 2019 13:54:30 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 13:54:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61CsEID36503890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 12:54:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 193E752051;
        Mon,  1 Jul 2019 12:54:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.66])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E8AB55204E;
        Mon,  1 Jul 2019 12:54:22 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] initramfs: read metadata from special file
 METADATA!!!
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-cpio@gnu.org,
        zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, rob@landley.net,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
Date:   Mon, 01 Jul 2019 08:54:12 -0400
In-Reply-To: <20190523121803.21638-3-roberto.sassu@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
         <20190523121803.21638-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070112-0016-0000-0000-0000028E22EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070112-0017-0000-0000-000032EBAFDE
Message-Id: <1561985652.4049.24.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

> diff --git a/init/initramfs.c b/init/initramfs.c
> index 5de396a6aac0..862c03123de8 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c

> +static int __init do_process_metadata(char *buf, int len, bool last)
> +{

Part of the problem in upstreaming CPIO xattr support has been the
difficulty in reading and understanding the initramfs code due to a
lack of comments.  At least for any new code, let's add some comments
to simplify the review.  In this case, understanding "last", before
reading the code, would help.

Mimi

> +	int ret = 0;
> +
> +	if (!metadata_buf) {
> +		metadata_buf_ptr = metadata_buf = kmalloc(body_len, GFP_KERNEL);
> +		if (!metadata_buf_ptr) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		metadata_len = body_len;
> +	}
> +
> +	if (metadata_buf_ptr + len > metadata_buf + metadata_len) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	memcpy(metadata_buf_ptr, buf, len);
> +	metadata_buf_ptr += len;
> +
> +	if (last)
> +		do_parse_metadata(previous_name_buf);
> +out:
> +	if (ret < 0 || last) {
> +		kfree(metadata_buf);
> +		metadata_buf = NULL;
> +		metadata = 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int __init do_copy(void)
>  {
>  	if (byte_count >= body_len) {
>  		if (xwrite(wfd, victim, body_len) != body_len)
>  			error("write error");
> +		if (metadata)
> +			do_process_metadata(victim, body_len, true);
>  		ksys_close(wfd);
>  		do_utime(vcollected, mtime);
>  		kfree(vcollected);
> @@ -458,6 +500,8 @@ static int __init do_copy(void)
>  	} else {
>  		if (xwrite(wfd, victim, byte_count) != byte_count)
>  			error("write error");
> +		if (metadata)
> +			do_process_metadata(victim, byte_count, false);
>  		body_len -= byte_count;
>  		eat(byte_count);
>  		return 1;
> 

